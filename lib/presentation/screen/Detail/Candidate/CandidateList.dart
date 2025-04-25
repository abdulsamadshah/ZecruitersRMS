import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/data/Services/CallHelper.dart';
import 'package:zecruiters_rms/data/models/CandiDateListRes.dart';
import 'package:zecruiters_rms/logic/bloc/CandiDate/candi_date_cubit.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';
import 'package:zecruiters_rms/presentation/screen/Detail/Candidate/CandidateDetail.dart';

import '../../../../gen/fonts.gen.dart';
import '../../Widget/CandiDate_widget.dart';
import 'FilterBottomSheet.dart';
import 'RecordCall.dart';

class CandidateListScreen extends StatefulWidget {
  String jdId;
  int listType;
  CandidateListScreen({super.key, required this.jdId, required this.listType});

  @override
  State<CandidateListScreen> createState() => _CandidatedetailScreenState();
}

class _CandidatedetailScreenState extends State<CandidateListScreen> {
  final CandiDateCubit candiDateCubit = CandiDateCubit();
  final CandiDateCubit RemarksCubit = CandiDateCubit();
  TextEditingController Search_Values = TextEditingController();
  @override
  void initState() {
    super.initState();
    candiDateCubit.getCandidateData(
        jdId: widget.jdId, listType: widget.listType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(
        context,
        title: "Candidate Lists",
        type: "basic",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: reausableIcon(
              icon: Icons.filter_alt,
              size: 30,
              color: Colors.white,
              ontap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return FilterBottomSheetsUi(productCubit: candiDateCubit);
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: TextField(
              controller: Search_Values,
              onChanged: (value) {
                candiDateCubit.searchCandiDate(value);
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: reausableIcon(
                        icon: Icons.search,
                        size: 23.sp,
                        color: Color(0xff534A4A),
                      ),
                    ),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: FontFamily.interMedium,
                  ),
                  counterText: "",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.r)),
                      borderSide: BorderSide(
                          width: 1.5.w,
                          style: BorderStyle.solid,
                          color: ToggleThemeData.Appcolor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.r)),
                      borderSide: BorderSide(
                          width: 1.5.w,
                          style: BorderStyle.solid,
                          color: ToggleThemeData.Appcolor)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ToggleThemeData.Appcolor, width: 1.5.w),
                      borderRadius: BorderRadius.all(Radius.circular(50.r))),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ToggleThemeData.Appcolor, width: 1.5.w),
                      borderRadius: BorderRadius.all(Radius.circular(50.r))),
                  hintText: "Search CandiDates",
                  hintStyle: TextStyle(color: Colors.black45),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.only(top: 0.h, left: 0.w, bottom: 20.h),
                  suffixIcon: InkWell(
                    onTap: () {
                      Search_Values.text = "";
                      candiDateCubit.getCandidateData(
                          jdId: widget.jdId, listType: widget.listType);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(7.r),
                      child: CircleAvatar(
                        radius: 16.r,
                        backgroundColor: ToggleThemeData.Appcolor,
                        child: reausableIcon(
                            icon: Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                  suffixStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: FontFamily.interMedium,
                  )),
              style: TextStyle(
                color: Colors.black,
                fontFamily: FontFamily.interMedium,
                fontSize: 15.sp,
              ),
            ),
          ),
          BlocConsumer<CandiDateCubit, CandiDateState>(
            bloc: candiDateCubit,
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case LoadingState:
                  return CandiDateListUi(context, isLoading: true);

                case LoadingError:
                  final networkconnectionlost = state as LoadingError;
                  return LostinternetConnection(
                      retry: () {
                        candiDateCubit.getCandidateData(
                            jdId: widget.jdId, listType: widget.listType);
                      },
                      messgae: networkconnectionlost.error.toString());

                case CandiDateLoadingSuccess:
                  final list = state as CandiDateLoadingSuccess;
                  if (list.listData!.isEmpty) {
                    return Align(
                        alignment: Alignment.center,
                        child: reausabletext("No Data Found"));
                  } else {
                    return CandiDateListUi(context, data: list.listData);
                  }

                default:
                  return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget CandiDateListUi(
    BuildContext context, {
    List<CandiDateData>? data,
    bool isLoading = false,
  }) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data?.length ?? 10,
        itemBuilder: (ctx, index) {
          final user = data?[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (context) => RecordCall(),
                  builder: (context) => CandidateDetailScreen(
                    jdId: user!.jdId.toString(),
                    candiDateId: user.id.toString(),
                    mobNo: user.contactNo.toString(),
                  ),
                ),
              ).then((value) {
                if(value==true){
                  candiDateCubit.getCandidateData(
                      jdId: widget.jdId, listType: widget.listType);
                }
              },);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
              child: Card(
                elevation: 6,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 28.r,
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.person,
                              size: 28.r,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildDetailRow("Name",
                                    '${user?.firstName ?? "N/A"} ${user?.lastName ?? ""}',
                                    height: 3, color: Colors.black),
                                buildDetailRow(
                                    "Email", '${user?.emailId ?? "N/A"}',
                                    height: 3, color: Colors.black),
                                buildDetailRow(
                                    "Mobile", '${user?.contactNo ?? "N/A"}',
                                    height: 3, color: Colors.black),
                                buildDetailRow(
                                    "JD ID", '${user?.jdId ?? "N/A"}',
                                    height: 3, color: Colors.black),
                                buildDetailRow("Total Call Duration",
                                    '${user?.totalCallDuration ?? "N/A"}',
                                    height: 3, color: Colors.black),
                                user?.remarkst == ""
                                    ? SizedBox()
                                    : buildDetailRow(
                                        "Remarks", '${user?.remarkst ?? ""}',
                                        height: 3, color: Colors.black),
                                user?.remarks == ""
                                    ? SizedBox()
                                    : buildDetailRow(
                                        "Comment", '${user?.remarks ?? ""}',
                                        height: 3, color: Colors.black),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          _buildIconButton(
                            icon: Icons.email,
                            color: Colors.blue,
                            onTap: () async {
                              String url = "mailto:${user?.emailId ?? ""}";
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not send the email.';
                              }
                            },
                          ),
                          _buildIconButton(
                            icon: FontAwesomeIcons.whatsapp,
                            color: Colors.teal,
                            onTap: () async {
                              CallHelper().launchWhatsAppChooser("${user?.contactNo}");
                            },
                          ),

                          _buildIconButton(
                            icon: Icons.edit,
                            color: Colors.green,
                            onTap: () async {
                              RemarksCubit.SelectedRemarks({
                                // 'id':"15",
                                'id': user?.remarkstid.toString(),
                                'remarks': user?.remarkst.toString()
                              });
                              RemarksCubit.comments.text = user!.remarks!.toString();
                              RemarksCubit.getReMarkList(
                                context,
                                cubit: RemarksCubit,
                                jdId: user!.jdId.toString(),
                                mobNo: user.contactNo.toString(),
                                candidateid: user.id,
                                RemarkCallBack: (success) {
                                  if (success) {
                                    candiDateCubit.getCandidateData(
                                        jdId: widget.jdId, listType: widget.listType);
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
    );
  }

  // Helper Method for Icon Button with Background
  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), // Light background with the same color
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 28.r,
          color: color,
        ),
      ),
    );
  }
}
