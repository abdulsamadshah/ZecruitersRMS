import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:zecruiters_rms/core/theme/themes_data.dart';

import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';

import '../../../gen/fonts.gen.dart';
import '../../data/models/RemakListRes.dart';
import '../../logic/bloc/CandiDate/candi_date_cubit.dart';
import 'CustomDropdown.dart';

class DialogBox {
  static Future<void> confirmationDialog(BuildContext context,
      {String? title,
      String? desc,
      String lefButtonName = "NO",
      String rightButtonName = "YES",
      void Function()? leftButtonOntap,
      rightButtonOntap}) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                reausabletext(
                  title!.tr,
                  fontfamily: FontFamily.interSemiBold,
                  fontsize: 17,
                  align: TextAlign.center,
                ),
                desc == null
                    ? const SizedBox()
                    : reausabletext(
                        desc.tr,
                        fontfamily: FontFamily.interMedium,
                        fontsize: 13,
                      ),
              ],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: leftButtonOntap,
              child: reausabletext(
                lefButtonName.tr,
                color: context.isDarkMode
                    ? ToggleThemeData.white
                    : ToggleThemeData.black,
                fontsize: 16,
              ),
            ),
            CupertinoDialogAction(
              onPressed: rightButtonOntap,
              child: reausabletext(rightButtonName.tr,
                  color: ToggleThemeData.Appcolor, fontsize: 16),
            ),
          ],
        );
      },
    );
  }

  static RemarkDialog(BuildContext context,
      {required CandiDateCubit candiDateCubit,
      void Function(bool)? callBack}) async {
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return WillPopScope(
                onWillPop: () async {
                  return true;
                },
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  content: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Form(
                          key: candiDateCubit.remarkKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              reausabletext("Fill Remark Detail",
                                  fontfamily: FontFamily.interBold,
                                  fontsize: 20),
                              SizedBox(
                                height: 20.h,
                              ),
                              reausabletext("Select Remark"),
                              SizedBox(
                                height: 5.h,
                              ),
                              CustomDropdown(
                                items: candiDateCubit.state.remarkData ?? [],
                                hintText: "Select Client Name",
                                selectedItem:
                                    candiDateCubit.state.SelectedremarkData !=
                                            null
                                        ? RemakListData(
                                            id: candiDateCubit.state
                                                    .SelectedremarkData['id'] ??
                                                "",
                                            remarks: candiDateCubit.state
                                                        .SelectedremarkData[
                                                    'remarks'] ??
                                                "Unknown",
                                          )
                                        : null,
                                onChanged: (RemakListData? value) {
                                  if (value != null) {
                                    candiDateCubit.SelectedRemarks({
                                      'id': value.id,
                                      'remarks': value.remarks
                                    });
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15.h,
                              ),

                              reausabletext("Enter Comment"),
                              SizedBox(
                                height: 5.h,
                              ),
                              TextFormField(
                                controller: candiDateCubit.comments,
                                keyboardType: TextInputType.text,
                                // validator: (value) {
                                //   if (value!.isEmpty ||
                                //       value == null ||
                                //       value == "") {
                                //     return "Comment can't be empty";
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: ToggleThemeData.textbordercolor,
                                        width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: ToggleThemeData.textbordercolor,
                                        width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: ToggleThemeData.Appcolor,
                                        width: 2.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: ToggleThemeData.textbordercolor,
                                        width: 2.0),
                                  ),
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Enter Comments",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 15.sp),
                                  contentPadding: EdgeInsets.only(
                                      top: 10.h, left: 15.w, bottom: 0.h),
                                ),
                                style: const TextStyle(color: Colors.black),
                                maxLines: 3,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              reausablebuttons(
                                borderradiues: 25,
                                title: "Submit",
                                textcolor: Colors.black,
                                ontap: () {
                                  if (candiDateCubit.remarkKey.currentState!
                                      .validate()) {
                                    callBack!(true);
                                  }
                                },
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              );
            }));
  }
}
