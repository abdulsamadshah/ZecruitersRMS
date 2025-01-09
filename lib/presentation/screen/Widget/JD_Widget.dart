import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/data/models/JDListResponse.dart';
import 'package:zecruiters_rms/data/models/JobDetailResponse.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';

Widget buildHeaderCell(String title, int width) {
  return reausabletext(
    title,
    fontsize: 14,
    fontweight: FontWeight.bold,
    color: Colors.white,
    align: TextAlign.center,
    widths: width,
  );
}

Widget buildBodyCell(String title, int width) {
  return reausabletext(
    title,
    fontsize: 14,
    color: Colors.black,
    align: TextAlign.center,
    widths: width,
  );
}

Widget buildUploaderCell(BuildContext context, String title, double width,
    {void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width.w,
      alignment: Alignment.center,
      child: reausabletext(
        title,
        fontsize: 14,
        color: Colors.blue,
        decorattion: TextDecoration.underline,
      ),
    ),
  );
}

class JobDetailUi extends StatelessWidget {
  Job_DetailData? detail;
  final bool isLoading;

  JobDetailUi({Key? key, this.detail, this.isLoading = false})
      : super(key: key);

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: ToggleThemeData.Appcolor,
                        child: Text(
                          detail?.jdId?.substring(0, 2).toUpperCase() ?? "--",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reausabletext(
                              detail?.jdDesignation ?? "Unknown Designation",
                              fontsize: 20,
                              fontweight: FontWeight.bold,
                            ),
                            SizedBox(height: 4.h),
                            reausabletext(
                              detail?.jdLocation ?? "Unknown Location",
                              fontsize: 14,
                              color: Colors.grey,
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
                  _buildSectionTitle("Job Details"),
                  _buildDetailRow("Experience",
                      "${detail?.jdExperianceFrom ?? 0} - ${detail?.jdExperianceTo ?? 0} years"),
                  _buildDetailRow("Age",
                      "${detail?.jdAgeFrom ?? '-'} - ${detail?.jdAgeTo ?? '-'} years"),
                  _buildDetailRow("Gender Preference", detail?.jdGender),
                  _buildDetailRow("FCTC", detail?.jdFctc),
                  _buildDetailRow("TCTC", detail?.jdTctc),
                  _buildDetailRow("Variable Pay", detail?.jdVariable),
                  _buildDetailRow("Pincode", detail?.jdPincode),
                  _buildDetailRow(
                      "Number of Candidates", detail?.jdNcandidates),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        reausabletext(
                          "Skill",
                          fontsize: 16,
                          fontweight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        HtmlWidget(
                          detail?.jdSkill ?? '',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: reausabletext(
                            "Preference",
                            fontsize: 16,
                            fontweight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: HtmlWidget(
                            detail?.jdPreference ?? '',
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Company Details Section
                  Divider(color: Colors.grey.shade300, thickness: 1),
                  SizedBox(height: 12.h),
                  _buildSectionTitle("Company Details"),
                  _buildDetailRow("Company Name", detail?.cname),
                  _buildDetailRow("Industry Name", detail?.industryName),
                  _buildDetailRow(
                      "Department", detail?.departmentSUbCategoryMasterName),
                  _buildDetailRow(
                      "Sub-Functions", detail?.departmentSubFunctionsName),

                  SizedBox(height: 20.h),

                  // Description Section
                  _buildSectionTitle("Job Description"),
                  SizedBox(height: 8.h),
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Padding(
                      padding: EdgeInsets.all(12.0.w),
                      child: HtmlWidget(
                        detail?.jdDescription ?? "No description available.",
                        textStyle: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: reausabletext(
              label,
              fontsize: 16,
              fontweight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Expanded(
            flex: 3,
            child: reausabletext(
              value ?? "-",
              fontsize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return reausabletext(title,
        fontsize: 17, fontweight: FontWeight.bold, color: Colors.blueGrey);
  }
}
