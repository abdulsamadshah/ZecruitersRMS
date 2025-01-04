

import 'package:go_router/go_router.dart';
import 'package:zecruiters_rms/Routers/app_route_constants.dart';
import 'package:zecruiters_rms/core/constant/SecureSharedPref.dart';
import 'package:zecruiters_rms/core/constant/global.dart';


class AppServices {




  userAuth(context) async {
    await Future.delayed(const Duration(seconds: 2));

    if (Global.storageServices.get(SecureSharedPreference.deviceToken) !=
        null ) {
      GoRouter.of(context).goNamed(MyAppRouteConstants.dashBoardScreen);
    } else {
      GoRouter.of(context).goNamed(MyAppRouteConstants.loginScreen);
    }
  }


}
