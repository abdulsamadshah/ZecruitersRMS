import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:zecruiters_rms/Routers/app_route_constants.dart';
import 'package:zecruiters_rms/core/constant/Dialog.dart';
import 'package:zecruiters_rms/core/constant/appTheme.dart';
import 'package:zecruiters_rms/core/constant/global.dart';
import 'package:zecruiters_rms/gen/fonts.gen.dart';
import 'package:zecruiters_rms/logic/bloc/Dashboard/dashboard_cubit.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';
import 'package:zecruiters_rms/presentation/screen/Dashboard/NavigationBar.dart';

import '../../../core/theme/themes_data.dart';
import '../Widget/order_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // firebaseNotificationServices notificationServices =
  // firebaseNotificationServices();
  final dashCubit = DashboardCubit();
  var selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();

    dashCubit.getDashBoardData(selectedDate: selectedDate);
    // checkNotificationPermission();
    // notificationServices.setupInteractMessage(context);
    // notificationServices.getDiviceToken();
  }

  Future<void> checkNotificationPermission() async {
    // await notificationServices.askPermission();
  }

  Future<void> pickDate(BuildContext context,
      {required DashboardCubit cubit}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;
      cubit.getDashBoardData(selectedDate: pickedDate);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Navigationbar(
            // profileState: ProfileState,
            ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ToggleThemeData.Appcolor,
                  ToggleThemeData.purple,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  leading: Builder(
                    builder: (context) => InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: reausableIcon(
                          icon: Icons.menu, color: Colors.white, size: 30),
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(left: 0.w),
                      child: InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 28.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 27.r,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                NetworkImage(MyAppTheme.ProfilenotFoundImg),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                      height: 10.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<DashboardCubit, DashboardState>(
          bloc: dashCubit,
          builder: (context, state) => Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: 150.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ToggleThemeData.Appcolor,
                      ToggleThemeData.purple,
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reausabletext("Welcome",
                          fontfamily: FontFamily.interBold,
                          fontsize: 30,
                          color: ToggleThemeData.white,
                          fontweight: FontWeight.w800),
                      reausabletext(
                          "${Global.storageServices.getProfileData().firstName.toString() ?? ""} ${Global.storageServices.getProfileData().lastName.toString() ?? ""}",
                          fontfamily: FontFamily.interMedium,
                          fontsize: 20,
                          color: ToggleThemeData.white),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 110.h,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: ToggleThemeData.white,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd').format(
                                selectedDate,
                              ),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today,
                                  color: Colors.blue),
                              onPressed: () =>
                                  pickDate(context, cubit: dashCubit),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OrderWidget(
                              color: Color.fromRGBO(5, 0, 255, 0.9),
                              image: AssetImage('asset/images/docc1.png'),
                              percent: '0',
                              subTitle: 'Total CALL',
                              title: state.detail?.tOTALCALL ?? "0",
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            OrderWidget(
                              color: Color.fromRGBO(0, 184, 212, 1),
                              image: AssetImage('asset/images/doc4.png'),
                              percent: '0',
                              subTitle: 'Valid CALL',
                              title: state.detail?.vALIDCALL ?? "0",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  ),
                  // height: 580.h,
                ),
              ),
            ],
          ),
        ));
  }
}

Widget CategoryUi() {
  // Dummy data for products
  List<Map<String, String>> dummyProducts = [
    {
      "name": "MIS",
      "image":
          "https://cdn-icons-png.flaticon.com/512/9402/9402405.png", // Placeholder image
    },
    {
      "name": "JD",
      "image":
          "https://icon-library.com/images/job-icon-png/job-icon-png-15.jpg", // Placeholder image
    },
  ];

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
    child: GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: dummyProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 170.h,
        crossAxisSpacing: 15.w,
        crossAxisCount: 2,
        mainAxisSpacing: 15.h,
      ),
      itemBuilder: (context, index) {
        return productCatListUi(
          productName: dummyProducts[index]['name']!,
          productImage: dummyProducts[index]['image']!,
          ontap: () {
            if (dummyProducts[index]['name'].toString() == "MIS") {
              GoRouter.of(context)
                  .pushNamed(MyAppRouteConstants.Misdetailscreen);
            } else {
              GoRouter.of(context)
                  .pushNamed(MyAppRouteConstants.JobdetailScreen);
            }
          },
        );
      },
    ),
  );
}

Widget productCatListUi(
    {required final String productName,
    required final String productImage,
    void Function()? ontap,
    void Function()? wishlishitemontap,
    String? defaultcard}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.only(top: 15.h),
      decoration: BoxDecoration(
          boxShadow: defaultcard != null
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          border: defaultcard != null
              ? Border.all(
                  color: Colors.deepPurpleAccent.withOpacity(0.5), width: 1)
              : Border.all(color: const Color(0xffDEDEDE), width: 1.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: CNetworkImage(
                imgurl: productImage, width: 90, height: 90, borderradiues: 0),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
            child: reausabletext(
              productName,
              align: TextAlign.center,
              maxline: 2,
              fontsize: 15,
              fontfamily: FontFamily.interSemiBold,
            ),
          ),
        ],
      ),
    ),
  );
}
