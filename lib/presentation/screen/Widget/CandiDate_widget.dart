import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zecruiters_rms/data/models/CandiDateDetailRes.dart';



// Helper to get initials for the avatar
String getInitials({CandiDateDetail? detail}) {
  final firstNameInitial =
      detail?.firstName?.isNotEmpty == true ? detail!.firstName![0] : "";
  final lastNameInitial =
      detail?.lastName?.isNotEmpty == true ? detail!.lastName![0] : "";
  return "$firstNameInitial$lastNameInitial".toUpperCase();
}

// Detail Row Widget
Widget buildDetailRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: Row(
      children: [
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildIconButton({
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

String formatCallDuration(String duration) {
  try {
    final parts = duration.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);

    final StringBuffer buffer = StringBuffer();
    if (hours > 0) buffer.write('$hours ${hours > 1 ? "hours" : "hour"} ');
    if (minutes > 0)
      buffer.write('$minutes ${minutes > 1 ? "minutes" : "minute"}');
    return buffer.toString().trim();
  } catch (e) {
    return "Invalid duration";
  }
}

Widget buildTextRow(String label, String? value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: Row(
      children: [
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value ?? "N/A",
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
