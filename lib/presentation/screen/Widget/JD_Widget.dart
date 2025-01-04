import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';

Widget buildHeaderCell(String title, int width) {
  return reausabletext(
    title,
    fontsize: 14,
    fontweight: FontWeight.bold,
    color: Colors.white,
    align: TextAlign.center,
    widths: width,
  );
}

Widget buildBodyCell(String title, int width) {
  return reausabletext(
    title,
    fontsize: 14,
    color: Colors.black,
    align: TextAlign.center,
    widths: width,
  );
}

Widget buildUploaderCell(BuildContext context, String title, double width,{void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width.w,
      alignment: Alignment.center,
      child: reausabletext(
        title,
        fontsize: 14,
        color: Colors.blue,
        decorattion: TextDecoration.underline,
      ),
    ),
  );
}
