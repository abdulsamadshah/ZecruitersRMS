

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zecruiters_rms/core/Utils/Context_Utility.dart';
import 'package:zecruiters_rms/gen/fonts.gen.dart';

class CommonDialog {
  static errorMessage(String? title) {
    showCupertinoDialog(
      barrierDismissible: false,
      context: ContextUtility.context!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Padding(
            padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
            child: Text(
              title.toString(),
              style: TextStyle(
                fontFamily: FontFamily.interMedium,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 1700), () {
      Navigator.of(ContextUtility.context!).pop();
    });
  }

}
