import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';
import 'package:zecruiters_rms/presentation/screen/Widget/order_widget.dart';

class Misdetailscreen extends StatefulWidget {
  const Misdetailscreen({super.key});

  @override
  State<Misdetailscreen> createState() => _MisdetailscreenState();
}

class _MisdetailscreenState extends State<Misdetailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, title: "MIS Detail", type: "basic"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const OrderWidget(
                  color: Color.fromRGBO(5, 0, 255, 0.9),
                  image: AssetImage('asset/images/docc1.png'),
                  percent: '0',
                  subTitle: 'Pending Calls',
                  title: '04',
                ),
                SizedBox(
                  width: 15.w,
                ),
                const OrderWidget(
                  color: Color.fromRGBO(0, 184, 212, 1),
                  image: AssetImage('asset/images/doc4.png'),
                  percent: '0',
                  subTitle: 'Total Calls',
                  title: '10',
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            const OrderWidget(
              color: Color.fromRGBO(117, 227, 79, 1),
              image: AssetImage('asset/images/doc3.png'),
              percent: '0',
              subTitle: 'Completed Calls',
              title: '20',
            ),
          ],
        ),
      ),
    );
  }
}
