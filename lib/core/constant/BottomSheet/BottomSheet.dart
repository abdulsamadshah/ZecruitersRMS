import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:zecruiters_rms/Routers/app_route_constants.dart';
import 'package:zecruiters_rms/core/constant/Dialog/Common_dialog.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/gen/fonts.gen.dart';
import 'package:zecruiters_rms/logic/bloc/SignIn/sign_in_bloc.dart';

import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';



class BottomSheets {
  Future<void> veriefyOtp(
      context, {
        required SignInBloc signBloc,
        required String mobNo,
      }) async {
    final OTPInteractor _otpInteractor = OTPInteractor();

    OTPTextEditController? otpController;
    try {
      otpController = OTPTextEditController(
        codeLength: 4,
        onCodeReceive: (code) {
          if (code != null && code.isNotEmpty) {
            signBloc.add(otpEvent(int.parse(code)));
          }
        },
        otpInteractor: _otpInteractor, // Initialize this properly
      );

      otpController.startListenUserConsent((code) {
        try {
          if (code == null || code.isEmpty) {
            return '';
          }
          final exp = RegExp(r'(\d{4})');
          final extractedCode = exp.stringMatch(code);

          if (extractedCode != null) {
            signBloc.add(otpEvent(int.parse(extractedCode)));
          }

          return extractedCode ?? '';
        } catch (e) {
          return '';
        }
      });
    } catch (e) {
      log('Error initializing OTPTextEditController: $e');
    }

    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: BlocBuilder<SignInBloc, SignInState>(
            bloc: signBloc,
            builder: (context, state) => Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 0.w,
                right: 0.w,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                  ),
                  color: ToggleThemeData.white,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            "OTP has send on $mobNo",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: FontFamily.interMedium,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3.h),
                          child: Text.rich(
                            style: TextStyle(fontSize: 15.sp),
                             const TextSpan(children: [
                              TextSpan(
                                text: 'OTP',
                              ),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red),
                              ),
                            ]),
                          ),
                        ),
                        TextFormField(
                          controller: otpController,
                          maxLength: 4,
                          onChanged: (value) {
                            if (value.isNotEmpty &&
                                RegExp(r'^\d+$').hasMatch(value)) {
                              signBloc.add(otpEvent(int.parse(value)));
                            }
                          },
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null ||
                                value.length != 4 ||
                                !RegExp(r'^\d{4}$').hasMatch(value)) {
                              return 'Enter a valid 4-digit OTP';
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontFamily: FontFamily.interRegular,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.r),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.r),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.r),
                              borderSide: const BorderSide(
                                  color: ToggleThemeData.Appcolor, width: 2.0),
                            ),
                            isDense: true,
                            counterText: "",
                            hintText: "Please enter the OTP",
                            fillColor: Colors.white,
                            counterStyle: TextStyle(
                              color: Colors.transparent,
                              fontSize: 17.sp,
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              fontFamily: FontFamily.interRegular,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h),

                        reausablebuttons(
                          title: "Submit".tr,
                          enable: state.otp.toString().length != 4 ? false : true,
                          ontap: () {
                            if (state.otp.toString().length.toString() == "4") {
                              // GoRouter.of(context)
                              //     .pushNamed(MyAppRouteConstants.dashBoardScreen);
                              Navigator.pop(context);
                              // GoRouter.of(context).pushNamed(
                              //     MyAppRouteConstants
                              //         .personalDetailScreen,
                              //     pathParameters: {
                              //       "profileData": jsonEncode({}),
                              //     });
                            } else {
                              CommonDialog.errorMessage("Please Enter OTP!");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

