# White X VPN

Flutter VPN app with [xray-core](https://github.com/xtls/xray-core) backend.

## Prerequisites

- Flutter 3.10+
- Go 1.22+
- gomobile:
  ```bash
  make -C packages/xray-mobile setup
  ```
- Android NDK (for Android builds)
- Xcode (for iOS builds)

## Build

### 1. Build native libraries

```bash
# Both platforms
make -C packages/xray-mobile all

# Or one at a time
make -C packages/xray-mobile android
make -C packages/xray-mobile ios
```

This only needs to be re-run when `packages/xray-mobile/` changes.

### 2. Build the app

```bash
# Android
flutter build apk

# iOS
flutter build ios
```

## Project structure

```
├── lib/                     # Dart source
│   ├── provider/            # State management
│   ├── service/             # Platform channel services
│   └── view/                # UI
├── packages/
│   └── xray-mobile/         # Go wrapper around xray-core (see its README)
├── android/                 # Android native
│   └── app/libs/            # gomobile .aar output (gitignored)
└── ios/                     # iOS native
    └── Xraymobile.xcframework/  # gomobile xcframework output (gitignored)
```
