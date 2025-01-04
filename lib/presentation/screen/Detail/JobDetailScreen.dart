import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';
import 'package:zecruiters_rms/presentation/screen/Detail/Candidate/CandidateList.dart';
import 'package:zecruiters_rms/presentation/screen/Widget/JD_Widget.dart';

import 'Candidate/CandidateDetail.dart';

class JobDetail extends StatefulWidget {
  const JobDetail({Key? key}) : super(key: key);

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  final List<Map<String, dynamic>> tableData = [
    {
      "JD Id": "Z-2937",
      "Sourced": 13,
      "Pending": 0,
      "In Process": 3,
      "Shortlisted": 0,
      "L2 Pending": 0,
      "Uploader": "View"
    },
    {
      "JD Id": "Z-2936",
      "Sourced": 26,
      "Pending": 2,
      "In Process": 19,
      "Shortlisted": 0,
      "L2 Pending": 0,
      "Uploader": "View"
    },  {
      "JD Id": "Z-2937",
      "Sourced": 13,
      "Pending": 0,
      "In Process": 3,
      "Shortlisted": 0,
      "L2 Pending": 0,
      "Uploader": "View"
    },
    {
      "JD Id": "Z-2936",
      "Sourced": 26,
      "Pending": 2,
      "In Process": 19,
      "Shortlisted": 0,
      "L2 Pending": 0,
      "Uploader": "View"
    },  {
      "JD Id": "Z-2937",
      "Sourced": 13,
      "Pending": 0,
      "In Process": 3,
      "Shortlisted": 0,
      "L2 Pending": 0,
      "Uploader": "View"
    },
    {
      "JD Id": "Z-2936",
      "Sourced": 26,
      "Pending": 2,
      "In Process": 19,
      "Shortlisted": 0,
      "L2 Pending": 0,
      "Uploader": "View"
    },  {
      "JD Id": "Z-2937",
      "Sourced": 13,
      "Pending": 0,
      "In Process": 3,
      "Shortlisted": 0,
      "L2 Pending": 0,
      "Uploader": "View"
    },
    {
      "JD Id": "Z-2936",
      "Sourced": 26,
      "Pending": 2,
      "In Process": 19,
      "Shortlisted": 0,
      "L2 Pending": 0,
      "Uploader": "View"
    },  {
      "JD Id": "Z-2937",
      "Sourced": 13,
      "Pending": 0,
      "In Process": 3,
      "Shortlisted": 0,
      "L2 Pending": 0,
      "Uploader": "View"
    },
    {
      "JD Id": "Z-2936",
      "Sourced": 26,
      "Pending": 2,
      "In Process": 19,
      "Shortlisted": 0,
      "L2 Pending": 0,
      "Uploader": "View"
    },  {
      "JD Id": "Z-2937",
      "Sourced": 13,
      "Pending": 0,
      "In Process": 3,
      "Shortlisted": 0,
      "L2 Pending": 0,
      "Uploader": "View"
    },
    {
      "JD Id": "Z-2936",
      "Sourced": 26,
      "Pending": 2,
      "In Process": 19,
      "Shortlisted": 0,
      "L2 Pending": 0,
      "Uploader": "View"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, title: "JD Detail", type: "basic"),
      body: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: SingleChildScrollView(
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
                    buildHeaderCell("Uploader", 100),
                  ],
                ),
              ),
              // Scrollable Body
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: tableData.map((row) {
                      return Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Row(
                          children: [
                            buildBodyCell(row["JD Id"].toString(), 80),
                            buildBodyCell(row["Sourced"].toString(), 80),
                            buildBodyCell(row["Pending"].toString(), 80),
                            buildBodyCell(row["In Process"].toString(), 100),
                            buildBodyCell(row["Shortlisted"].toString(), 100),
                            buildBodyCell(row["L2 Pending"].toString(), 100),
                            buildUploaderCell(
                                context, row["Uploader"].toString(), 100,onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  CandidateListScreen(),));
                                },),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}


