import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallHelper {


  static Future<void> makeDirectCall(String phoneNumber) async {
    try {
     await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } on PlatformException catch (e) {
      print("Error making call: ${e.message}");
    }
  }


  void launchWhatsAppChooser(String phone) async {

    final Uri whatsappUri = Uri.parse("https://wa.me/+91$phone");

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(
          whatsappUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint("Could not launch WhatsApp URL");
      }
    } catch (e) {
      debugPrint("Error launching WhatsApp: $e");
    }
  }






}