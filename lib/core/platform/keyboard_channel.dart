import 'package:flutter/services.dart';

class KeyboardChannel {
  static const _channel = MethodChannel('com.aswat.alquloob/keyboard');

  static Future<bool> isKeyboardEnabled() async {
    try {
      final result = await _channel.invokeMethod<bool>('isKeyboardEnabled');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  static Future<void> openKeyboardSettings() async {
    try {
      await _channel.invokeMethod<void>('openKeyboardSettings');
    } on PlatformException {
      // Platform does not support this operation.
    }
  }

  static Future<void> showKeyboardPicker() async {
    try {
      await _channel.invokeMethod<void>('switchToKeyboard');
    } on PlatformException {
      // Platform does not support this operation.
    }
  }
}
