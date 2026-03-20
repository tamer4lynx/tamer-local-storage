'background only';

declare const NativeModules: {
  NativeLocalStorageModule?: {
    setStorageItem(key: string, value: string): void;
    getStorageItem(key: string, callback: (value: string) => void): void;
    clearStorage(): void;
  };
};

class LocalStorage implements Storage {
  private _length: number = 0;

  get length(): number {
    return this._length;
  }

  getItem(key: string): string | null {
    if (!NativeModules?.NativeLocalStorageModule) {
      return null;
    }

    let result: string | null = null;

    NativeModules.NativeLocalStorageModule.getStorageItem(key, (value: string) => {
      result = value || null;
    });

    return result;
  }

  setItem(key: string, value: string): void {
    if (!NativeModules?.NativeLocalStorageModule) {
      throw new DOMException('localStorage is not available', 'NotSupportedError');
    }

    try {
      NativeModules.NativeLocalStorageModule.setStorageItem(key, String(value));
      this._updateLength();
    } catch (e) {
      throw new DOMException('Failed to set item', 'QuotaExceededError');
    }
  }

  removeItem(key: string): void {
    if (!NativeModules?.NativeLocalStorageModule) {
      return;
    }

    NativeModules.NativeLocalStorageModule.setStorageItem(key, '');
    this._updateLength();
  }

  clear(): void {
    if (!NativeModules?.NativeLocalStorageModule) {
      return;
    }

    NativeModules.NativeLocalStorageModule.clearStorage();
    this._length = 0;
  }

  key(index: number): string | null {
    return null;
  }

  private _updateLength(): void {
    this._length = 0;
  }
}

export const localStorage = new LocalStorage();

// Side-effect: make localStorage available globally when module is imported
// Note: In ES modules, this runs for both named and side-effect imports
// It's idempotent (only sets if not already present)
if (typeof globalThis !== 'undefined' && !(globalThis as any).localStorage) {
  (globalThis as any).localStorage = localStorage;
}
