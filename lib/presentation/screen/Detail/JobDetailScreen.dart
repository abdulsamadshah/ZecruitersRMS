import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';
import 'package:zecruiters_rms/data/models/JDListResponse.dart';
import 'package:zecruiters_rms/logic/bloc/jd_detail_cubit.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';
import 'package:zecruiters_rms/presentation/screen/Widget/JD_Widget.dart';

import 'Candidate/JobDetailScreen.dart';

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
      appBar: mainAppBar(context, title: "JD Detail", type: "basic"),
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
          Skeletonizer(
            enabled: isLoading,
            child: Container(
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
          ),
          // Safely handle `data` nullability
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: isLoading
                    ? List.generate(
                        20,
                        (index) => JdDetailData(context,
                            row: null)) // Display 5 dummy rows during loading
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
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Jobdetailscreen(
                        jdId: row!.jDID.toString(),
                      ),
                    ));
              },
              child: buildBodyCell(row?.jDID?.toString() ?? "-", 80)),
          buildBodyCell(row?.sOURCED?.toString() ?? "-", 80),
          buildBodyCell(row?.pENDING?.toString() ?? "-", 80),
          buildBodyCell(row?.iNPROCESS?.toString() ?? "-", 100),
          buildBodyCell(row?.sHORTLIST?.toString() ?? "-", 100),
          buildBodyCell(row?.l2PENDING?.toString() ?? "-", 100),
          buildBodyCell(row?.cLIENTNAME?.toString() ?? "-", 200),
          buildBodyCell(row?.dESIGNATION?.toString() ?? "-", 200),
        ],
      ),
    );
  }
}
