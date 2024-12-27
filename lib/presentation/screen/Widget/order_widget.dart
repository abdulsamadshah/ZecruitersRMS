import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/gen/fonts.gen.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';

class OrderWidget extends StatefulWidget {
  final Color color;
  final AssetImage image;
  final String percent;
  final String title;
  final String subTitle;
  const OrderWidget(
      {super.key,
      required this.color,
      required this.image,
      required this.percent,
      required this.title,
      required this.subTitle});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165.w,
      // height: 145.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          colors: [
            ToggleThemeData.purple,
            ToggleThemeData.Appcolor,
             ToggleThemeData.purple,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
                color: widget.color,
                // borderRadius: BorderRadius.circular(30.r),
                shape: BoxShape.circle),
            child: Center(child: Image(image: widget.image)),
          ),
          SizedBox(
            height: 10.h,
          ),
          reausabletext(widget.title,
              fontfamily: 'Poppins',
              color: Color.fromRGBO(255, 255, 255, 1),
              fontsize: 22,
              fontweight: FontWeight.w500),
          SizedBox(
            height: 5.h,
          ),
          reausabletext(widget.subTitle,
              fontfamily: FontFamily.interMedium,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontsize: 13,
              fontweight: FontWeight.w400),
        ],
      ),
    );
  }
}
