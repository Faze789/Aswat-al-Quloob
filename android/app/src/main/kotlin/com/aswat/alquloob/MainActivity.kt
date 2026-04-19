package com.aswat.alquloob

import android.content.Intent
import android.provider.Settings
import android.view.inputmethod.InputMethodManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "com.aswat.alquloob/keyboard"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isKeyboardEnabled" -> {
                        val imm = getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager
                        val isEnabled = imm.enabledInputMethodList.any {
                            it.packageName == packageName
                        }
                        result.success(isEnabled)
                    }
                    "openKeyboardSettings" -> {
                        startActivity(
                            Intent(Settings.ACTION_INPUT_METHOD_SETTINGS).apply {
                                flags = Intent.FLAG_ACTIVITY_NEW_TASK
                            }
                        )
                        result.success(null)
                    }
                    "switchToKeyboard" -> {
                        val imm = getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager
                        imm.showInputMethodPicker()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
