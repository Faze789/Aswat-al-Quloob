package com.aswat.alquloob

import android.inputmethodservice.InputMethodService
import android.view.View
import android.view.inputmethod.EditorInfo
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.android.FlutterView
import io.flutter.plugin.common.MethodChannel

/**
 * System-level input method service that provides the Aswat al-Quloob
 * Arabic keyboard to all apps on the device.
 *
 * Architecture:
 *   A dedicated [FlutterEngine] is spun up inside the service so the
 *   keyboard UI is rendered by Flutter. A [MethodChannel] named
 *   "com.aswat.alquloob/ime" lets the Dart side commit text, delete
 *   backward, or fire editor actions through [currentInputConnection].
 */
class AswatInputMethodService : InputMethodService() {

    private var flutterEngine: FlutterEngine? = null
    private var flutterView: FlutterView? = null

    override fun onCreate() {
        super.onCreate()

        flutterEngine = FlutterEngine(this).apply {
            dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )
            FlutterEngineCache.getInstance().put("keyboard_engine", this)
        }

        flutterEngine?.let { engine ->
            MethodChannel(
                engine.dartExecutor.binaryMessenger,
                "com.aswat.alquloob/ime"
            ).setMethodCallHandler { call, result ->
                when (call.method) {
                    "commitText" -> {
                        val text = call.argument<String>("text") ?: ""
                        currentInputConnection?.commitText(text, 1)
                        result.success(null)
                    }
                    "deleteBackward" -> {
                        currentInputConnection?.deleteSurroundingText(1, 0)
                        result.success(null)
                    }
                    "sendAction" -> {
                        currentInputConnection?.performEditorAction(
                            EditorInfo.IME_ACTION_DONE
                        )
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }

    override fun onCreateInputView(): View {
        flutterView = FlutterView(this).also { view ->
            flutterEngine?.let { view.attachToFlutterEngine(it) }
        }
        return flutterView!!
    }

    override fun onDestroy() {
        flutterView?.detachFromFlutterEngine()
        flutterEngine?.destroy()
        FlutterEngineCache.getInstance().remove("keyboard_engine")
        super.onDestroy()
    }
}
