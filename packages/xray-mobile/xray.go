package xraymobile

import (
	"fmt"
	"strings"
	"sync"

	"github.com/xtls/xray-core/core"
	_ "github.com/xtls/xray-core/main/distro/all"
)

var (
	instance *core.Instance
	mu       sync.Mutex
)

// StartXray starts the xray-core instance with the given JSON config.
func StartXray(configJSON string) error {
	mu.Lock()
	defer mu.Unlock()

	if instance != nil {
		return fmt.Errorf("xray is already running")
	}

	config, err := core.LoadConfig("json", strings.NewReader(configJSON))
	if err != nil {
		return fmt.Errorf("failed to load config: %w", err)
	}

	inst, err := core.New(config)
	if err != nil {
		return fmt.Errorf("failed to create xray instance: %w", err)
	}

	if err := inst.Start(); err != nil {
		return fmt.Errorf("failed to start xray: %w", err)
	}

	instance = inst
	return nil
}

// StopXray stops the running xray-core instance.
func StopXray() error {
	mu.Lock()
	defer mu.Unlock()

	if instance == nil {
		return fmt.Errorf("xray is not running")
	}

	if err := instance.Close(); err != nil {
		return fmt.Errorf("failed to stop xray: %w", err)
	}

	instance = nil
	return nil
}

// IsRunning returns whether xray-core is currently active.
func IsRunning() bool {
	mu.Lock()
	defer mu.Unlock()
	return instance != nil
}

// GetVersion returns the xray-core version string.
func GetVersion() string {
	return core.Version()
}
