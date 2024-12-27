import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';

import '../../../data/models/UserModel.dart';
import '../../common_widget/common_widget.dart';

class Jobdetail extends StatefulWidget {
  const Jobdetail({super.key});

  @override
  State<Jobdetail> createState() => _JobdetailState();
}

class _JobdetailState extends State<Jobdetail> {
  List<UserModel> dummyUsers = [
    UserModel(
      name: "Samad",
      email: "sabdulsamad272@gmail.com",
      mobileNumber: "7249303582",
      whatsappNumber: "7249303582",
    ),
    UserModel(
      name: "Bob Johnson",
      email: "bob.johnson@example.com",
      mobileNumber: "2345678901",
      whatsappNumber: "2345678901",
    ),
    UserModel(
      name: "Charlie Brown",
      email: "charlie.brown@example.com",
      mobileNumber: "3456789012",
      whatsappNumber: "3456789012",
    ),
    UserModel(
      name: "Diana Prince",
      email: "diana.prince@example.com",
      mobileNumber: "4567890123",
      whatsappNumber: "4567890123",
    ),
    UserModel(
      name: "Ethan Hunt",
      email: "ethan.hunt@example.com",
      mobileNumber: "5678901234",
      whatsappNumber: "5678901234",
    ),
    UserModel(
      name: "Fiona Gallagher",
      email: "fiona.gallagher@example.com",
      mobileNumber: "6789012345",
      whatsappNumber: "6789012345",
    ),
    UserModel(
      name: "George Michael",
      email: "george.michael@example.com",
      mobileNumber: "7890123456",
      whatsappNumber: "7890123456",
    ),
    UserModel(
      name: "Hannah Montana",
      email: "hannah.montana@example.com",
      mobileNumber: "8901234567",
      whatsappNumber: "8901234567",
    ),
    UserModel(
      name: "Isaac Newton",
      email: "isaac.newton@example.com",
      mobileNumber: "9012345678",
      whatsappNumber: "9012345678",
    ),
    UserModel(
      name: "Julia Roberts",
      email: "julia.roberts@example.com",
      mobileNumber: "0123456789",
      whatsappNumber: "0123456789",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, title: "JD Detail", type: "basic"),
      body: ListView.builder(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dummyUsers.length,
        itemBuilder: (ctx, index) {
          final user = dummyUsers[index];

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    reausabletext(
                      'Name: ${user.name}',
                      fontsize: 15,
                      fontweight: FontWeight.bold,
                    ),
                    SizedBox(height: 8.h),
                    reausabletext(
                      'Email: ${user.email}',
                      fontsize: 13,
                      color: Colors.grey[700],
                    ),
                    SizedBox(height: 4.h),
                    reausabletext(
                      'Mobile: ${user.mobileNumber}',
                      fontsize: 13,
                      color: Colors.grey[700],
                    ),
                    SizedBox(height: 4.h),
                    reausabletext(
                      'WhatsApp: ${user.whatsappNumber ?? "N/A"}',
                      fontsize: 13,
                      color: Colors.grey[700],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            String url = "tel:${user.mobileNumber}";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not make the phone call.';
                            }
                          },
                          icon: reausableIcon(
                              icon: Icons.call, color: Colors.white, size: 25),
                          label: reausabletext(
                            'Call',
                            fontsize: 13,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            String url = "https://wa.me/${user.whatsappNumber}";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not open WhatsApp.';
                            }
                          },
                          icon: reausableIcon(
                              icon: FontAwesomeIcons.whatsapp,
                              color: Colors.white,
                              size: 25),
                          label: reausabletext(
                            'WhatsApp',
                            fontsize: 13,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
