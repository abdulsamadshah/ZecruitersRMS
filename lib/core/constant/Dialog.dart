
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:zecruiters_rms/Routers/app_route_constants.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';

import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';

import '../../../gen/fonts.gen.dart';

class DialogBox {
  static Future<void> confirmationDialog(BuildContext context,
      {String? title,
        String? desc,
        String lefButtonName = "NO",
        String rightButtonName = "YES",
        void Function()? leftButtonOntap,
        rightButtonOntap}) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                reausabletext(
                  title!.tr,
                  fontfamily: FontFamily.interSemiBold,
                  fontsize: 17,
                  align: TextAlign.center,
                ),
                desc == null
                    ? const SizedBox()
                    : reausabletext(
                  desc.tr,
                  fontfamily: FontFamily.interMedium,
                  fontsize: 13,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: leftButtonOntap,
              child: reausabletext(
                lefButtonName.tr,
                color: context.isDarkMode
                    ? ToggleThemeData.white
                    : ToggleThemeData.black,
                fontsize: 16,
              ),
            ),
            CupertinoDialogAction(
              onPressed: rightButtonOntap,
              child: reausabletext(rightButtonName.tr,
                  color: ToggleThemeData.Appcolor, fontsize: 16),
            ),
          ],
        );
      },
    );
  }

  // static Future<void> logOutDialog(BuildContext buildcontext,
  //     {String? title,
  //     String? desc,
  //     String lefButtonName = "NO",
  //     String rightButtonName = "YES",
  //     required ProfileBloc profileBloc}) {
  //   return showCupertinoDialog(
  //     context: buildcontext,
  //     builder: (context) {
  //       return CupertinoAlertDialog(
  //         title: Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 15.w),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               SizedBox(
  //                 height: 15.h,
  //               ),
  //               reausabletext(
  //                 title!.tr,
  //                 fontfamily: FontFamily.interSemiBold,
  //                 fontsize: 17,
  //                 align: TextAlign.center,
  //               ),
  //               desc == null
  //                   ? const SizedBox()
  //                   : reausabletext(
  //                       desc.tr,
  //                       fontfamily: FontFamily.interMedium,
  //                       fontsize: 13,
  //                     ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           CupertinoDialogAction(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: reausabletext(
  //               lefButtonName.tr,
  //               color: context.isDarkMode
  //                   ? ToggleThemeData.white
  //                   : ToggleThemeData.black,
  //               fontsize: 16,
  //             ),
  //           ),
  //           CupertinoDialogAction(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               GoRouter.of(context).goNamed(MyAppRouteConstants.loginScreen);
  //
  //               // profileBloc.add(LogOutEvent(context));
  //             },
  //             child: reausabletext(rightButtonName.tr,
  //                 color: ToggleThemeData.Appcolor, fontsize: 16),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
