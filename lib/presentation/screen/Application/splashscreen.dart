import 'package:zecruiters_rms/data/Services/AppServices.dart';
import 'package:zecruiters_rms/gen/assets.gen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    AppServices().userAuth(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          Assets.images.appicon.path,
          height: 220.h,
          width: 250.w,
        ),
      ),
    );
  }

  Widget reausablesplash(
      {Alignment alignment = Alignment.centerRight,
      String? imagename,
      int left = 0,
      int right = 0,
      int bottom = 0,
      int top = 0}) {
    return Container(
      padding: EdgeInsets.only(
          top: top.h, left: left.w, right: right.w, bottom: bottom.h),
      child: Align(
        alignment: alignment,
        child: SvgPicture.asset(
          imagename.toString(),
        ),
      ),
    );
  }
}
