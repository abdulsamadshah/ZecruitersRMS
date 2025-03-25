import 'package:flutter/services.dart';

class CallHelper {
  static const MethodChannel _platform = MethodChannel('direct_call');

  static Future<void> makeDirectCall(String phoneNumber) async {
    try {
      await _platform.invokeMethod('makeDirectCall', {'phoneNumber': phoneNumber});
    } on PlatformException catch (e) {
      print("Error making call: ${e.message}");
    }
  }
}
