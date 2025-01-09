
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/gen/assets.gen.dart';
import 'package:zecruiters_rms/gen/fonts.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


Widget reausableIcon(
    {required IconData icon,
      Color? color,
      double size = 20,
      void Function()? ontap}) {
  return InkWell(
    onTap: ontap,
    child: Icon(
      icon,
      color: color,
      size: size.sp,
    ),
  );
}

AppBar appBar(
    BuildContext context, {
      void Function()? onback,
      String? title,
      String? menu,
      IconData? menuicon,
      void Function()? menuontap,
      GlobalKey? key,
      double elevation = 0,
    }) {
  return AppBar(
    centerTitle: true,
    elevation: elevation,
    leading: InkWell(
      onTap: onback,
      child: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black,
      ),
    ),
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    title: Text(
      key: key,
      "$title",
      style: TextStyle(
          fontFamily: FontFamily.interBold,
          fontSize: 21.sp,
          color: const Color(0xff525252)),
    ),
    actions: [
      menu != ""
          ? InkWell(
        onTap: menuontap,
        child: SizedBox(
          width: 40,
          child: Icon(
            menuicon,
            // FontAwesomeIcons.ellipsisVertical
            color: Colors.black,
            size: 22.sp,
          ),
        ),
      )
          : const SizedBox()
    ],
  );
}

Widget AppIconReusable() {
  return Image.asset(
    "assets/images/icon.png",
    height: 200.h,
    width: 200.h,
  );
}

Widget CNetworkImage(
    {String? imgurl,
      double borderradiues = 15,
      int height = 62,
      int width = 120,
      String? loading}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderradiues),
    child: CachedNetworkImage(
      width: width.w,
      height: height.h,
      imageUrl: "$imgurl",
      fit: BoxFit.fill,
      errorWidget: (context, url, error) => const SizedBox(),
      placeholder: (context, string) => loading == "no"
          ? const SizedBox()
          : const Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

Widget ReusableDivider(
    {int height = 1,
      int width = 340,
      double dividerheigth = 1,
      Color dividercolor = Colors.black}) {
  return SizedBox(
      height: height.h,
      width: width.w,
      child: Divider(
        height: dividerheigth,
        color: dividercolor,
      ));
}

Widget reausablebuttons(
    {void Function()? ontap,
      Color bgcolor = ToggleThemeData.purple,
      String? title,
      bool enable=true,
      int width = 375,
      int height = 50,
      Color textcolor = Colors.white,
      double borderradiues = 7,
      String? type,
      int fontsize = 18}) {
  return GestureDetector(
    onTap: enable==false?null:ontap,
    child: Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderradiues.r),
        color: enable==false?Colors.grey.shade300:bgcolor,
      ),
      child: Center(
        child: Text(
          "$title",
          style: TextStyle(
            color: Colors.white,
            fontSize: fontsize.sp,
            fontFamily: FontFamily.interSemiBold,
          ),
        ),
      ),
    ),
  );
}

Widget reausabletext(String title,
    {int fontsize = 15,
      Color? color,
      String fontfamily = "geographeditwebbold",
      FontWeight? fontweight,
      double? height,
      int? widths,
      TextDecoration? decorattion,
      Color? backcolor,
      TextAlign? align,
      int? maxline,
      TextOverflow? textoverflow,void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: widths?.w,
      child: Text(
        textAlign: align,
        title,
        maxLines: maxline,
        style: TextStyle(
            decoration: decorattion,
            backgroundColor: backcolor,
            height: height,
            fontFamily: fontfamily,
            fontSize: fontsize.sp,
            color: color,
            fontWeight: fontweight),
      ),
    ),
  );
}

Widget EmptyDataSvg({String? iconname}) {
  return Center(
    child: SvgPicture.asset(
      "$iconname",
    ),
  );
}

Widget EmptyDataPng({String? iconname}) {
  return Center(
    child: Image.asset(
      "$iconname",
    ),
  );
}

Widget LostinternetConnection(
    {String? showbutton, void Function()? retry, required String messgae}) {
  return Align(
    alignment: Alignment.center,
    child: Center(
        child: messgae == "An error occured please try again!"
            ?
        //------------------------ Internet Lost ------------------ //
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.images.lostInternets.path),
            reausabletext("Lost Connection",
                fontsize: 24, fontfamily: FontFamily.interBold),
            SizedBox(
              height: 10.h,
            ),
            reausabletext(
                "Whoops... no internet connection found. check you connection",
                fontsize: 15,
                color: Colors.grey,
                fontfamily: FontFamily.interMedium,
                widths: 260,
                align: TextAlign.center),
            SizedBox(
              height: 30.h,
            ),
            showbutton == "no"
                ? const SizedBox()
                : reausablebuttons(
                width: 180,
                title: "Try Again",
                textcolor: Colors.white,
                ontap: retry)
          ],
        )
        //------------------------ Server Error ------------------ //
            : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.images.serverError.path),
            reausabletext("Something went wrong",
                fontsize: 24, fontfamily: FontFamily.interBold),
            SizedBox(
              height: 10.h,
            ),
            reausabletext("Refresh the page",
                fontsize: 15,
                color: Colors.grey,
                fontfamily: FontFamily.interMedium,
                widths: 260,
                align: TextAlign.center),
            SizedBox(
              height: 30.h,
            ),
            showbutton == "no"
                ? const SizedBox()
                : reausablebuttons(
                width: 180,
                title: "Try Again",
                textcolor: Colors.white,
                ontap: retry)
          ],
        )),
  );
}


Widget assetImage(String name,{double? height,double? width}) {
  return Center(
    child: Image.asset(
      "$name",
      height: height?.h,
      width: width?.w,
    ),
  );
}



