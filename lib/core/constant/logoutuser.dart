
import 'package:flutter/material.dart';
import 'package:zecruiters_rms/core/constant/SecureSharedPref.dart';


import 'global.dart';

class LogoutUser {
  void logout(BuildContext context) {
    Global.storageServices.remove(SecureSharedPreference.deviceToken);
    Global.storageServices.remove(SecureSharedPreference.DEVICE_ID);

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/SIGN_IN', (Route<dynamic> route) => false);
  }
}
