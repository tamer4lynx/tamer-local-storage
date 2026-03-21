# @tamer4lynx/tamer-local-storage

Web-standard `localStorage` API for Lynx applications. Provides persistent key-value storage using native platform APIs (Android `SharedPreferences`, iOS `UserDefaults`).

## Installation

```bash
npm install @tamer4lynx/tamer-local-storage
```

Add to your app's dependencies and run `t4l link`. It is not part of `t4l add-core`; install it explicitly or use `t4l add tamer-local-storage`.

## Usage

This package supports two import styles:

### Named Import

```tsx
import { localStorage } from '@tamer4lynx/tamer-local-storage'

// Set an item
localStorage.setItem('username', 'john_doe')

// Get an item
const username = localStorage.getItem('username') // 'john_doe'

// Remove an item
localStorage.removeItem('username')

// Clear all items
localStorage.clear()
```

### Side-Effect Import (Global)

Import the module in your root file to make `localStorage` available globally, matching the web standard:

```tsx
// In your root file (e.g., src/index.tsx or src/App.tsx)
import '@tamer4lynx/tamer-local-storage'

// Now localStorage is available globally, just like in the browser
localStorage.setItem('username', 'john_doe')
const username = localStorage.getItem('username')
```

**Note:** Both import styles are supported. The side-effect (setting `globalThis.localStorage`) only runs if it doesn't already exist, so it's safe to use named imports even if the global is set elsewhere. You can also use the explicit `/global` entry point: `import '@tamer4lynx/tamer-local-storage/global'`.

## API

This package implements the [Web Storage API](https://developer.mozilla.org/en-US/docs/Web/API/Storage) standard:

| Method | Description |
|--------|-------------|
| `getItem(key: string)` | Returns the value for the given key, or `null` if not found |
| `setItem(key: string, value: string)` | Stores a key-value pair |
| `removeItem(key: string)` | Removes the item with the given key |
| `clear()` | Removes all stored items |
| `key(index: number)` | Returns the key at the given index (returns `null` - enumeration not supported) |
| `length` | Number of items (always `0` - enumeration not supported) |

**Note:** Key enumeration (`key()` and `length`) is not supported due to limitations of the underlying native storage APIs. The native module doesn't provide a way to list all keys efficiently.

## Platform Implementation

- **Android:** Uses `SharedPreferences` with preference name `"tamer_local_storage"`
- **iOS:** Uses `UserDefaults` with suite name `"com.nanofuxion.tamer.localstorage"` (falls back to standard if suite unavailable)

## Configuration

This package uses **lynx.ext.json** (RFC standard). The native module is automatically registered via autolink when you run `t4l link`.

## Credits

This package is based on the [Lynx Native Modules guide](https://lynxjs.org/guide/use-native-modules.md) and implements the Local Persistent Storage Module example from the [Lynx documentation](https://lynxjs.org/guide/use-native-modules.html).

Special thanks to the Lynx team for their excellent documentation and native module architecture.

## Development

```bash
npm run build
```

Emits JavaScript and declarations to `dist/` (same pattern as `@tamer4lynx/tamer-insets`).

- iOS: `pod lib lint packages/tamer-local-storage/ios/tamerlocalstorage/tamerlocalstorage.podspec`
- Android: build with Gradle from `packages/tamer-local-storage/android`
