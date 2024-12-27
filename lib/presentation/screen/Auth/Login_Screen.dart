
import 'package:zecruiters_rms/core/common_widget/Inputfield.dart';
import 'package:zecruiters_rms/core/constant/BottomSheet/BottomSheet.dart';
import 'package:zecruiters_rms/core/constant/validator.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/gen/fonts.gen.dart';
import 'package:zecruiters_rms/logic/bloc/SignIn/sign_in_bloc.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _logInKey = GlobalKey<FormState>();

  final loginBloc = SignInBloc();
  final verifyOtpBloc = SignInBloc();

  @override
  void dispose() {
    super.dispose();
    loginBloc.close();
  }

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      bloc: loginBloc,
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  height: 262.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.r),
                    color: ToggleThemeData.Appcolor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 90.h,
                        ),
                        reausabletext("Login",
                            color: Colors.white,
                            fontfamily: FontFamily.interBold,
                            fontsize: 30),
                        SizedBox(
                          height: 5.h,
                        ),
                        reausabletext("Welcome to Zecruiters RMS",
                            color: Colors.white,
                            fontfamily: FontFamily.interRegular,
                            fontsize: 18)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 200.h,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ToggleThemeData.white,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    height: 580.h,
                    child: Form(
                      key: _logInKey,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 15.w, top: 10.h, right: 15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            assetImage(Assets.images.appicon.path,
                                width: 150, height: 150),
                            SizedBox(
                              height: 50.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 3.h),
                              child: Text.rich(
                                  style: TextStyle(fontSize: 15.sp),
                                  const TextSpan(children: [
                                    TextSpan(
                                      text: 'Company Id',
                                    ),
                                    TextSpan(
                                        text: ' *',
                                        style: TextStyle(color: Colors.red)),
                                  ])),
                            ),
                            textfield(context,
                                hintname:
                                "Enter Company Id",
                                prefixicon: Icons.compress_sharp,
                              onChanged: (value) {
                                loginBloc.add(mobNoEvent(value.toString()));
                              },
                                validator: (value) {
                                  Validator
                                      .validate(value: value,title: "Company Id");
                                },),
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: 3.h),
                            //   child: Text.rich(
                            //       style: TextStyle(fontSize: 15.sp),
                            //       const TextSpan(children: [
                            //         TextSpan(
                            //           text: 'Mobile Number',
                            //         ),
                            //         TextSpan(
                            //             text: ' *',
                            //             style: TextStyle(color: Colors.red)),
                            //       ])),
                            // ),
                            // TextFormField(
                            //   maxLength: 10,
                            //   onChanged: (value) {
                            //     loginBloc.add(mobNoEvent(value.toString()));
                            //   },
                            //   keyboardType: TextInputType.number,
                            //   validator: (value) {
                            //     if (value!.isEmpty ||
                            //         !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            //       return 'Enter a valid 10-digit mobile number';
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            //   style: TextStyle(
                            //       fontSize: 17.sp,
                            //       fontFamily: FontFamily.interRegular),
                            //   decoration: InputDecoration(
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(7.r),
                            //         borderSide: const BorderSide(
                            //             color: Colors.grey, width: 1.0),
                            //       ),
                            //       enabledBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(7.r),
                            //         borderSide: const BorderSide(
                            //             color: Colors.grey, width: 1.0),
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(7.r),
                            //         borderSide: const BorderSide(
                            //             color: ToggleThemeData.Appcolor,
                            //             width: 2.0),
                            //       ),
                            //       isDense: true,
                            //       counterText: "",
                            //       fillColor: Colors.white,
                            //       counterStyle: TextStyle(
                            //           color: Colors.transparent,
                            //           fontSize: 17.sp),
                            //       filled: true,
                            //       hintText: "Enter your mobile number",
                            //       hintStyle: TextStyle(
                            //           fontFamily: FontFamily.interRegular,
                            //           fontSize: 15.sp)),
                            // ),
                            SizedBox(
                              height: 40.h,
                            ),
                            reausablebuttons(
                                title: "Login",
                                enable: state.mobNo.toString().length != 10
                                    ? false
                                    : true,
                                ontap: () {
                                  if (_logInKey.currentState!.validate()) {
                                    BottomSheets().veriefyOtp(context,
                                        signBloc: verifyOtpBloc,mobNo: state.mobNo);
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
