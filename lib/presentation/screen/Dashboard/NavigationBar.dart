import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zecruiters_rms/Routers/app_route_constants.dart';
import 'package:zecruiters_rms/core/constant/Dialog.dart';
import 'package:zecruiters_rms/core/constant/appTheme.dart';
import 'package:zecruiters_rms/core/constant/utility.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';

import '../../../gen/fonts.gen.dart';

class Navigationbar extends StatefulWidget {
  Navigationbar({
    super.key,
  });

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        width: 280.w,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.r),
          ),
        ),
        child: Column(
          children: [
            // Header Section
            Container(
              height: 180.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ToggleThemeData.Appcolor,
                    ToggleThemeData.purple,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 38.r,
                            backgroundImage:
                                NetworkImage(MyAppTheme.ProfilenotFoundImg),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reausabletext(
                              "Samad",
                              fontfamily: FontFamily.interBold,
                              fontsize: 20,
                              color: ToggleThemeData.white,
                              fontweight: FontWeight.w800,
                            ),
                            reausabletext(
                              "7249303582",
                              fontfamily: FontFamily.interRegular,
                              fontsize: 14,
                              color: ToggleThemeData.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
                height: 1,
                color: Colors.grey), // Divider for aesthetic separation

            // Menu Items Section
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                      ),
                      title: reausabletext(
                        "Home",
                        fontfamily: FontFamily.interMedium,
                        fontsize: 16,
                      ),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        // Navigate to Home
                      },
                    ),

                    const Divider(
                        height: 1,
                        color: Colors.grey), // Divider after Settings

                    ListTile(
                      leading: const Icon(
                        Icons.exit_to_app,
                      ),
                      title: reausabletext(
                        "Logout",
                        fontfamily: FontFamily.interMedium,
                        fontsize: 16,
                      ),
                      onTap: () {
                        DialogBox.confirmationDialog(context,
                            title: 'Are you sure?',
                            desc: "Do you really want to Delete?",
                            leftButtonOntap: () {
                          Navigator.pop(context);
                        }, rightButtonOntap: () {
                          Navigator.pop(context);
                          GoRouter.of(context)
                              .goNamed(MyAppRouteConstants.loginScreen);
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
