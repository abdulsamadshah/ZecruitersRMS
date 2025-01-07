import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';
import 'package:zecruiters_rms/data/models/JobDetailResponse.dart';
import 'package:zecruiters_rms/logic/bloc/jd_detail_cubit.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';

class Jobdetailscreen extends StatefulWidget {
  String jdId;
  Jobdetailscreen({super.key, required this.jdId});

  @override
  State<Jobdetailscreen> createState() => _JobdetailscreenState();
}

class _JobdetailscreenState extends State<Jobdetailscreen> {
  final JdDetailCubit jdDetail = JdDetailCubit();

  @override
  void initState() {
    jdDetail.getJDDetailData(jdid: widget.jdId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, title: "JD Detail", type: "basic"),
      body: BlocConsumer<JdDetailCubit, JdDetailState>(
        bloc: jdDetail,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoadingState:
              return JobDetailUi( isLoading: true);

            case LoadingError:
              final networkconnectionlost = state as LoadingError;
              return LostinternetConnection(
                  retry: () {
                    jdDetail.getJDListData();
                  },
                  messgae: networkconnectionlost.error.toString());

            case JobDetailLoadingSuccess:
              final list = state as JobDetailLoadingSuccess;
              if (list.detail==null) {
                return Align(
                    alignment: Alignment.center,
                    child: reausabletext("No Data Found"));
              } else {
                return JobDetailUi( detail: list.detail);
              }

            default:
              return const SizedBox();
          }
        },
      ));

  }


}





class JobDetailUi extends StatelessWidget {
  final JD_DetailData? detail;
  final bool isLoading;

  const JobDetailUi({Key? key, this.detail, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar and Job Designation
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colors.blueGrey,
                      child: Text(
                        detail?.jdId?.substring(0, 2).toUpperCase() ?? "--",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail?.jdDesignation ?? "Unknown Designation",
                            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            detail?.jdLocation ?? "Unknown Location",
                            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h),

                // Job Details Section
                Divider(color: Colors.grey.shade300, thickness: 1),
                SizedBox(height: 12.h),

                _buildDetailRow("Experience", "${detail?.jdExperianceFrom ?? 0} - ${detail?.jdExperianceTo ?? 0} years"),
                _buildDetailRow("Gender Preference", detail?.jdGender),
                _buildDetailRow("FCTC", detail?.jdFctc),
                _buildDetailRow("TCTC", detail?.jdTctc),
                _buildDetailRow("Variable Pay", detail?.jdVariable),

                SizedBox(height: 20.h),

                // Description Section
                Text(
                  "Job Description",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
                SizedBox(height: 8.h),
                Card(
                  elevation: 2,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  child: Padding(
                    padding: EdgeInsets.all(12.0.w),
                    child: Text(
                      detail?.jdDescription ?? "No description available.",
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? "-",
              style: TextStyle(fontSize: 16.sp, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

class JD_DetailData {
  final String? jdId;
  final String? jdDesignation;
  final String? jdLocation;
  final int? jdExperianceFrom;
  final int? jdExperianceTo;
  final String? jdGender;
  final String? jdFctc;
  final String? jdTctc;
  final String? jdVariable;
  final String? jdDescription;

  JD_DetailData({
    this.jdId,
    this.jdDesignation,
    this.jdLocation,
    this.jdExperianceFrom,
    this.jdExperianceTo,
    this.jdGender,
    this.jdFctc,
    this.jdTctc,
    this.jdVariable,
    this.jdDescription,
  });
}
