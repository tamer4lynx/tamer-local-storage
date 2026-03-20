'background only';

import { localStorage } from './index.js';

// Side-effect: make localStorage available globally when this module is imported
if (typeof globalThis !== 'undefined') {
  (globalThis as any).localStorage = localStorage;
}
