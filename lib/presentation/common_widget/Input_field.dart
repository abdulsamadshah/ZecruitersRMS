import 'package:zecruiters_rms/core/constant/utility.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/gen/fonts.gen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget InputField(
    {required String title,
    bool enabled = true,
    bool readOnly = false,
    InputDecoration? decoration,
    TextStyle hintstyle =
        const TextStyle(fontFamily: FontFamily.interMedium, fontSize: 15),
    bool obscureText = false,
    TextInputType? keyboardType = TextInputType.text,
    Widget? prefix,
    Widget? suffix,
    Widget? prefixIcon,
    suffixIcon,
    TextEditingController? controller,
    void Function()? onEditingComplete,
    void Function(String? value)? onChanged,
    void Function()? onTap,
    void Function(String? value)? onSaved,
    void Function(String? value)? onFieldSubmitted,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int? maxLength,
    int? maxLines,
    String? labelText,
    String? hintText,
    double? cursorHeight,
    double? width,
    String? initialValue,
    Color? fillColor,
    bool? filled,
    bool isRequired = false,
    GlobalKey? key,
    FocusNode? focusNode,
    Widget? RowIcon}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 3.h, left: 3.w),
              child: Text.rich(
                  style: TextStyle(fontSize: 15.sp),
                  TextSpan(children: [
                    TextSpan(
                        text: title,
                        style: TextStyle(
                          fontFamily: FontFamily.interRegular,
                          fontSize: 14.sp,
                        )),
                    const TextSpan(
                        text: ' *', style: TextStyle(color: Colors.red)),
                  ])),
            ),
            RowIcon ?? const SizedBox(),
          ],
        ),
        TextFormField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
              enabled: enabled,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              counterText: "",
              labelStyle: const TextStyle(
                color: Colors.black,
                fontFamily: FontFamily.interMedium,
              ),
              filled: true,
              fillColor: Colors.white,
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.r)),
                  borderSide: BorderSide(
                      width: 2.w,
                      style: BorderStyle.solid,
                      color: const Color(0xffDEDEDE))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.r)),
                  borderSide: BorderSide(
                      width: 2.w,
                      style: BorderStyle.solid,
                      color: ToggleThemeData.Appcolor)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xffDEDEDE), width: 1.w),
                  borderRadius: BorderRadius.all(Radius.circular(7.r))),
              // hintText: hintText,
              hintStyle: hintstyle,
              prefix: prefix,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              // Adjust padding

              suffix: suffix,
              suffixStyle: const TextStyle(
                color: Colors.black,
                fontFamily: FontFamily.interMedium,
              )),
          focusNode: focusNode,
          onChanged: onChanged,
          controller: controller,
          validator: validator,
          readOnly: readOnly,
          enabled: enabled,
          obscureText:
              Utility.isNullEmptyOrFalse(obscureText) ? false : obscureText,
          onEditingComplete: onEditingComplete,
          onSaved: onSaved,
          onTap: onTap,
          inputFormatters: inputFormatters,
          initialValue: initialValue,
          onFieldSubmitted: onFieldSubmitted,
          style: TextStyle(
            fontFamily: FontFamily.interRegular,
            fontSize: 14.sp,
          ),
          maxLength: maxLength,
          maxLines: maxLines,
        ),
      ],
    ),
  );
}


class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue previousValue,
      TextEditingValue newValue,
      ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}