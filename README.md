# qr-code-generator

A Flutter mobile app for generating QR codes with advanced features including customization, history, and bulk generation.

## Current setup (Phase 1)

This repository now includes a clean Flutter project scaffold with:

- **Core QR generation** from text/URL input
- **Real-time preview** while typing
- **Error correction level selection** (L, M, Q, H)
- **Customization controls**
  - Foreground color
  - Background color
  - QR size
  - Padding
  - Optional embedded logo image from gallery
- **Local history architecture** (repository abstraction + in-memory implementation)
- **Provider-based state management**
- **Material Design 3 app theme**
- **Starter widget tests** for preview and size customization behavior

## Project structure

- `lib/core`: shared models and repository contracts
- `lib/features/qr_generator`: QR generation feature layers (domain + presentation)
- `lib/features/history`: history repository implementation
- `test/`: widget tests

## Next planned steps

- Persist history with `sqflite` or `hive`
- Download/share/export QR images
- Bulk generation with CSV import + ZIP export
- Scanner flow with `qr_code_scanner`
