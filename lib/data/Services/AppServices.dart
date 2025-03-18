import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zecruiters_rms/Routers/app_route_constants.dart';
import 'package:zecruiters_rms/core/constant/SecureSharedPref.dart';
import 'package:zecruiters_rms/core/constant/global.dart';
import 'package:zecruiters_rms/presentation/CallRecord/CallRecording.dart';

class AppServices {
  userAuth(context) async {
    await Future.delayed(const Duration(seconds: 2));
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => CallScreen(),
    //     ));
    if (Global.storageServices.get(SecureSharedPreference.deviceToken) !=
        null ) {
      GoRouter.of(context).goNamed(MyAppRouteConstants.dashBoardScreen);
    } else {
      GoRouter.of(context).goNamed(MyAppRouteConstants.loginScreen);
    }
  }
}
