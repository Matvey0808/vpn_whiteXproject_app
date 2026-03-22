# xray-mobile

Go wrapper around [xray-core](https://github.com/xtls/xray-core) compiled via [gomobile](https://pkg.go.dev/golang.org/x/mobile/cmd/gomobile) for use as a native library in Android and iOS.

## Prerequisites

- Go 1.22+
- gomobile and gobind:
  ```bash
  go install golang.org/x/mobile/cmd/gomobile@latest
  go install golang.org/x/mobile/cmd/gobind@latest
  gomobile init
  ```
- Android NDK (for Android builds)
- Xcode command line tools (for iOS builds)

## Build

From this directory:

```bash
# Both platforms
make all

# Android only — outputs to android/app/libs/xraymobile.aar
make android

# iOS only — outputs to ios/Xraymobile.xcframework
make ios

# Remove build artifacts
make clean
```

## Updating xray-core

```bash
# Update to latest
go get github.com/xtls/xray-core@latest

# Or pin a specific version
go get github.com/xtls/xray-core@v1.260206.0

# Tidy dependencies
go mod tidy

# Rebuild
make all
```

## Exported API

| Function | Description |
|---|---|
| `StartXray(configJSON string) error` | Start xray-core with a JSON config |
| `StopXray() error` | Stop the running instance |
| `IsRunning() bool` | Check if xray-core is active |
| `GetVersion() string` | Get the xray-core version string |

## Origin

- **xray-core**: https://github.com/xtls/xray-core
- **gomobile**: https://pkg.go.dev/golang.org/x/mobile/cmd/gomobile
