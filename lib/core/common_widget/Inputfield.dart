


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zecruiters_rms/core/constant/appTheme.dart';
import 'package:zecruiters_rms/core/constant/utility.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';

Widget textfield(BuildContext context,
    {TextEditingController? textctr,
      String? hintname,
      IconData? prefixicon,
      void Function(String? value)? onChanged,
      String? Function(String?)? validator,
      void Function()? onTap,
      void Function(String? value)? onFieldSubmitted,
      bool enable = true,
      int? maxLength,
      double? width,
      TextInputType? keyboradtype,
      GlobalKey? key,
      List<TextInputFormatter>? inputFormatters,
      FocusNode? focusNode,Widget? suffix}) {
  return MyAppTheme.customizedTextFormField(
    filled: true,
    onTap: onTap,
    onFieldSubmitted: onFieldSubmitted,
    inputFormatters: inputFormatters,
    focusNode: focusNode,
    fillColor:  Colors.white,
    context,

suffix: suffix,
    width: width,
    onChanged: onChanged,
    keyboardType: keyboradtype,
    enabled: enable,
    maxLength: maxLength,
    controller: textctr,
    validator: validator,
    hintText: hintname,
    prefixIcon: Utility.isNotNullEmptyOrFalse(prefixicon)?Icon(
      prefixicon,
      size: 23.sp,
      color:  context.isDarkMode
          ? ToggleThemeData.white
          :const Color(0xff534A4A),
    ):null

  );
}