
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/gen/fonts.gen.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';



PreferredSize mainAppBar(BuildContext context,
    {String? title, bool centerTitle = true,String? type,bool isLeading=true}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ToggleThemeData.Appcolor,
            ToggleThemeData.purple,
          ],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular( type=="basic"?0.r:15.r),
        ),
      ),
      child: AppBar(
        leading: isLeading==false?SizedBox():Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: type=="basic"?reausableIcon(
              icon: Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ):CircleAvatar(
              radius: 15.r,
              backgroundColor: Colors.white,
              child: reausableIcon(
                icon: Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
            ),
          ),
        ),
        centerTitle: centerTitle,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: reausabletext(
          title ?? "",
          color: Colors.white,
          fontfamily: FontFamily.interSemiBold,
        ),
        actions: [
          // Padding(
          //   padding: EdgeInsets.only(left: 0.w),
          //   child: InkWell(
          //     onTap: () {},
          //     child: CircleAvatar(
          //       radius: 18.r,
          //       backgroundColor: Colors.white,
          //       child: reausableIcon(
          //           icon: Icons.notifications_outlined,
          //           color: Colors.black,
          //           size: 23),
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 10.w,
            height: 10.h,
          ),
        ],
      ),
    ),
  );
}