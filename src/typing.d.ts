declare let NativeModules: {
  NativeLocalStorageModule?: {
    setStorageItem(key: string, value: string): void;
    getStorageItem(key: string, callback: (value: string) => void): void;
    clearStorage(): void;
  };
};
