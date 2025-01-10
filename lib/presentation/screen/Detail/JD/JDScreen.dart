import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';
import 'package:zecruiters_rms/data/models/JDListResponse.dart';
import 'package:zecruiters_rms/logic/bloc/jd_detail_cubit.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';
import 'package:zecruiters_rms/presentation/screen/Detail/Candidate/CandidateList.dart';
import 'package:zecruiters_rms/presentation/screen/Widget/JD_Widget.dart';

import 'JobDetailScreen.dart';

class JobDetail extends StatefulWidget {
  const JobDetail({super.key});

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  final JdDetailCubit jdDetail = JdDetailCubit();

  @override
  void initState() {
    jdDetail.getJDListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, title: "JD Lists", type: "basic"),
      body: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: BlocConsumer<JdDetailCubit, JdDetailState>(
            bloc: jdDetail,
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case LoadingState:
                  return JD_DetailUi(context, isLoading: true);

                case LoadingError:
                  final networkconnectionlost = state as LoadingError;
                  return LostinternetConnection(
                      retry: () {
                        jdDetail.getJDListData();
                      },
                      messgae: networkconnectionlost.error.toString());

                case JdDetailLoadingSuccess:
                  final list = state as JdDetailLoadingSuccess;
                  if (list.listData!.isEmpty) {
                    return Align(
                        alignment: Alignment.center,
                        child: reausabletext("No Data Found"));
                  } else {
                    return JD_DetailUi(context, data: list.listData);
                  }

                default:
                  return const SizedBox();
              }
            },
          )),
    );
  }



  Widget JD_DetailUi(BuildContext context,
      {List<JDData>? data, bool isLoading = false}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Scrollable Header
          Container(
            height: 50.h,
            color: Colors.black,
            child: Row(
              children: [
                buildHeaderCell("JD Id", 80),
                buildHeaderCell("Sourced", 80),
                buildHeaderCell("Pending", 80),
                buildHeaderCell("In Process", 100),
                buildHeaderCell("Shortlisted", 100),
                buildHeaderCell("L2 Pending", 100),
                buildHeaderCell("Client Name", 200),
                buildHeaderCell("Designation", 200),
              ],
            ),
          ),
          // Scrollable Body
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: isLoading
                    ? List.generate(
                    20,
                        (index) => JdDetailData(context,
                        row: null)) // Display skeleton rows during loading
                    : (data ?? []).map((row) {
                  return JdDetailData(context, row: row);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget JdDetailData(BuildContext context, {JDData? row}) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          buildClickableCell(
            context,
            content: row?.jDID?.toString() ?? "-",
            width: 80,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Jobdetailscreen(
                    jdId: row?.jDID.toString() ?? "",
                  ),
                ),
              );
            },
          ),
          buildClickableCell(
            context,
            content: row?.sOURCED?.toString() ?? "-",
            width: 80,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidateListScreen(
                    jdId: row?.jDID.toString() ?? "",
                    listType: 1,
                  ),
                ),
              );
            },
          ),
          buildClickableCell(
            context,
            content: row?.pENDING?.toString() ?? "-",
            width: 80,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidateListScreen(
                    jdId: row?.jDID.toString() ?? "",
                    listType: 2,
                  ),
                ),
              );
            },
          ),
          buildClickableCell(
            context,
            content: row?.iNPROCESS?.toString() ?? "-",
            width: 100,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidateListScreen(
                    jdId: row?.jDID.toString() ?? "",
                    listType: 3,
                  ),
                ),
              );
            },
          ),
          buildClickableCell(
            context,
            content: row?.sHORTLIST?.toString() ?? "-",
            width: 100,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidateListScreen(
                    jdId: row?.jDID.toString() ?? "",
                    listType: 4,
                  ),
                ),
              );
            },
          ),
          buildClickableCell(
            context,
            content: row?.l2PENDING?.toString() ?? "-",
            width: 100,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidateListScreen(
                    jdId: row?.jDID.toString() ?? "",
                    listType: 5,
                  ),
                ),
              );
            },
          ),
          buildClickableCell(
            context,
            content: row?.cLIENTNAME?.toString() ?? "-",
            width: 200,
          ),
          buildClickableCell(
            context,
            content: row?.dESIGNATION?.toString() ?? "-",
            width: 200,
          ),
        ],
      ),
    );
  }

  Widget buildClickableCell(BuildContext context,
      {required String content,
        required double width,
        VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          content,
          style: TextStyle(
            fontSize: 14.sp,
            color: onTap != null ? Colors.blue : Colors.grey[800],
            fontWeight: onTap != null ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget buildHeaderCell(String title, double width) {
    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

}



















