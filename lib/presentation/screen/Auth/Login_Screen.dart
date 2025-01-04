import 'package:go_router/go_router.dart';
import 'package:zecruiters_rms/Routers/app_route_constants.dart';
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                height: 200.h,
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
                        height: 30.h,
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
                  top: 140.h,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: ToggleThemeData.white,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Form(
                    key: _logInKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15.w, top: 10.h, right: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          assetImage(Assets.images.appicon.path,
                              width: 250, height: 150),
                          SizedBox(
                            height: 50.h,
                          ),
                          title('Company Id'),
                          textfield(
                            context,
                            hintname: "Enter Company Id",
                            prefixicon: Icons.cabin,
                            onChanged: (value) {
                              loginBloc
                                  .add(companyIdEvent(value.toString()));
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Company Id is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          title('Email Id'),
                          textfield(
                            context,
                            hintname: "Enter Email Id",
                            prefixicon: Icons.email,
                            onChanged: (value) {
                              loginBloc.add(emailIdEvent(value.toString()));
                            },
                            validator: Validator.validateEmail,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          title('Password'),
                          textfield(context,
                              hintname: "Enter Password",
                              prefixicon: Icons.lock, onChanged: (value) {
                                loginBloc.add(passwordEvent(value.toString()));
                              }, validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                return null;
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
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.h),
        child: reausablebuttons(
            title: "Login",
            ontap: () {
              if (_logInKey.currentState!.validate()) {
                loginBloc.add(LoginEvent(context,));
              }
            }),
      ),
    );
  }

  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: reausabletext(title,
          fontfamily: FontFamily.interRegular, fontsize: 14),
    );
  }
}
