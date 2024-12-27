

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';

class Utils {
  static void fluttertoast(String message,
      {ToastGravity gravitys = ToastGravity.BOTTOM,
      Toast toastlenght = Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravitys,
        // timeInSecForIosWeb: 1,

        backgroundColor: ToggleThemeData.Appcolor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showSnackBar(
    BuildContext context, {
    required String message,
    int durationSeconds = 2,
    int fontSize = 15,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    Animation<double>? animation,
  }) {
    final snackBar = SnackBar(
      content: reausabletext(
        message,
        fontsize: fontSize,
      ),
      duration: Duration(seconds: durationSeconds),
      behavior: behavior,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: const EdgeInsets.all(10.0),
      backgroundColor: ToggleThemeData.Appcolor,
      animation: animation,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
