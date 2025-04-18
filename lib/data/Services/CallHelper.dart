import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/cupertino.dart';
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


  void launchWhatsAppChooser(String phone) async {
    final String phoneNumber = phone.replaceAll('+', '').replaceAll(' ', '');

    try {
      final intent = AndroidIntent(
        action: 'android.intent.action.SEND',
        type: 'text/plain',
        data: Uri.encodeFull("https://wa.me/$phoneNumber"),
        package: null, // null shows a chooser
      );
      await intent.launch();
    }  catch (e) {
      debugPrint("Error launching WhatsApp: $e");
    }
  }
}
