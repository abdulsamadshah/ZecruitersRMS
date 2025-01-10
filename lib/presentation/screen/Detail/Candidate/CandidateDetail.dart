import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';

import '../../../common_widget/common_widget.dart';

class CandidateDetailScreen extends StatelessWidget {
  final Map<String, String> candidate = {
    "name": "Samad",
    "profession": "Software Developer",
    "email": "sabdulsamad272@gmail.com",
    "mobile": "7249303582",
    "location": "New York, USA",
  };

  CandidateDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, title: "Candidate Details", type: "basic"),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(),
                const Divider(),
                _buildDetailRow("Email", candidate["email"]!),
                _buildDetailRow("Mobile", candidate["mobile"]!),
                const Divider(),
                _buildActionButtons(context),
                SizedBox(height: 20.h),

                //Play Call Record audio Button
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundColor: Colors.indigo.shade100,
          child: Text(
            candidate["name"]![0],
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                candidate["name"]!,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                candidate["profession"]!,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                candidate["location"]!,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _reusableButton(
          label: "Call",
          icon: Icons.call,
          color: Colors.green,
          onPressed: () async {
            // FlutterPhoneDirectCaller.callNumber("7249303582").then((value) {
            //   if(value==true){
            //     // Recordinging Started
            //   }
            // },);


          },
        ),
        _reusableButton(
          label: "Email",
          icon: Icons.email,
          color: Colors.blue,
          onPressed: () {
            // Email functionality
          },
        ),
        _reusableButton(
          label: "Location",
          icon: FontAwesomeIcons.locationArrow,
          color: Colors.red,
          onPressed: () {
            // Location functionality
          },
        ),
      ],
    );
  }

  Widget buildContactOption(BuildContext context, String label, String? value,
      IconData icon, String url,
      {Color color = Colors.blue}) {
    if (value == null || value.isEmpty)
      return SizedBox.shrink(); // Return empty widget if no value

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          leading: reausableIcon(icon: icon, color: color, size: 24),
          title:
              reausabletext(label, fontsize: 16, fontweight: FontWeight.bold),
          subtitle: reausabletext(value, fontsize: 14),
          trailing: reausableIcon(icon: Icons.arrow_forward_ios, size: 16),
          onTap: () async {
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
        Divider(thickness: 1.0),
      ],
    );
  }



  Widget _reusableButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white, size: 20.sp),
      label: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }


}
