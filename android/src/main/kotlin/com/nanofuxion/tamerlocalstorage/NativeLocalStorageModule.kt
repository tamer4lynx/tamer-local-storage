package com.nanofuxion.tamerlocalstorage

import android.content.Context
import com.lynx.jsbridge.LynxMethod
import com.lynx.jsbridge.LynxModule
import com.lynx.react.bridge.Callback

class NativeLocalStorageModule(context: Context) : LynxModule(context) {

    companion object {
        private const val PREFS_NAME = "tamer_local_storage"
    }

    private fun getSharedPreferences() = mContext.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    @LynxMethod
    fun setStorageItem(key: String, value: String) {
        getSharedPreferences().edit().putString(key, value).apply()
    }

    @LynxMethod
    fun getStorageItem(key: String, callback: Callback) {
        val value = getSharedPreferences().getString(key, "") ?: ""
        callback.invoke(value)
    }

    @LynxMethod
    fun clearStorage() {
        getSharedPreferences().edit().clear().apply()
    }
}
