


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zecruiters_rms/core/constant/utility.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/gen/fonts.gen.dart';


class MyAppTheme {
  static String notFoundImg = "https://via.placeholder.com/350x150";
  static String ProfilenotFoundImg =
      "https://st3.depositphotos.com/9998432/13335/v/450/depositphotos_133351928-stock-illustration-default-placeholder-man-and-woman.jpg";

  static Widget customizedTextFormField(BuildContext context,
      {bool enabled = true,
      bool readOnly = false,
      InputDecoration? decoration,
      TextStyle? hintstyle,
      bool obscureText = false,
      TextInputType? keyboardType = TextInputType.text,
      TextInputAction? textInputAction = TextInputAction.next,
      Widget? prefix,
      Widget? suffix,
      Widget? prefixIcon,
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
      int borderRadius = 10}) {
    return SizedBox(
      width: width?.w,
      child: TextFormField(
        key: key,
        cursorColor: ToggleThemeData.black,
        cursorHeight: cursorHeight,

        keyboardType: keyboardType,

        decoration: InputDecoration(
            enabled: enabled,
            prefixIcon: prefixIcon ?? null,
            labelStyle: const TextStyle(
              fontFamily: FontFamily.interMedium,
            ),
            counterText: "",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)),
                borderSide: const BorderSide(
                    width: 1, style: BorderStyle.solid, color: Colors.red)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)),
                borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: ToggleThemeData.Appcolor)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xffe8e8e8), width: 1.5.w),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius.r))),
            hintText: hintText,
            hintStyle: hintstyle,
            prefix: prefix,
            filled: filled,
            fillColor: fillColor,
            contentPadding: EdgeInsets.only(
                top: 0.h, left: 10.w, bottom: 20.h, right: 10.w),
            suffixIcon: suffix ?? null,
            suffixStyle: const TextStyle(
              fontFamily: FontFamily.interMedium,
            )),
        focusNode: focusNode,
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        textInputAction: textInputAction,
        readOnly: readOnly,
        enabled: enabled,
        obscureText:
            Utility.isNullEmptyOrFalse(obscureText) ? false : obscureText,
        onEditingComplete: onEditingComplete,
        onSaved: onSaved,
        onTap: onTap,
        inputFormatters: inputFormatters,

        initialValue: initialValue,
        //inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmitted,
        style: TextStyle(
          fontFamily: FontFamily.interMedium,
          fontSize: 15.sp,
        ),

        maxLength: maxLength,
        maxLines: maxLines,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Convert the text to uppercase
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator(
      {super.key,
      this.height = 1,
      this.color = Colors.grey,
      this.dashWidth = 2.0});
  final double height;
  final double dashWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        // const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
