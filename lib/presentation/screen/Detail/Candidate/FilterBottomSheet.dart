// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../../../gen/fonts.gen.dart';
import '../../../../core/theme/themes_data.dart';
import '../../../../logic/bloc/CandiDate/candi_date_cubit.dart';
import '../../../common_widget/common_widget.dart';

class FilterBottomSheetsUi extends StatelessWidget {
  final CandiDateCubit productCubit;

  const FilterBottomSheetsUi({Key? key, required this.productCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  productCubit.resetFilters();
                  Navigator.pop(context);
                },
                child: reausabletext(
                  'Reset',
                  color: ToggleThemeData.Appcolor,
                  fontsize: 16,
                  fontfamily: FontFamily.interSemiBold,
                ),
              ),
              reausabletext(
                'Filter',
                fontsize: 16,
                fontfamily: FontFamily.interSemiBold,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: reausableIcon(icon: Icons.close, size: 23),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Sort Alphabetically
          Card(
            surfaceTintColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            child: BlocBuilder<CandiDateCubit, CandiDateState>(
              bloc: productCubit,
              builder: (context, state) {
                return ListTile(
                  leading: reausableIcon(
                      icon: Icons.sort_by_alpha, color: Colors.blue),
                  title: reausabletext('Sort A to Z',fontsize: 14),
                  trailing: Checkbox(
                    value: productCubit.isAZSorted,
                    onChanged: (value) {
                      productCubit.sortProductsAlphabetically(value ?? false);
                    },
                  ),
                );
              },
            ),
          ),
          // SizedBox(height: 10.h),
          //
          //
          // Card(
          //   elevation: 4,
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          //   child: BlocBuilder<CandiDateCubit, CandiDateState>(
          //     bloc: productCubit,
          //     builder: (context, state) {
          //       return ListTile(
          //         leading: reausableIcon(
          //             icon: Icons.attach_money, color: Colors.orange),
          //         title: reausabletext(
          //           fontsize: 14,
          //             'Price: ${productCubit.isPriceLowToHigh ? 'Lowest to Highest' : 'Highest to Lowest'}'),
          //         trailing: CupertinoSwitch(
          //           value: productCubit.isPriceLowToHigh,
          //           onChanged: (value) {
          //             productCubit
          //                 .filterByPrice(value ? 'lowToHigh' : 'highToLow');
          //           },
          //         ),
          //       );
          //     },
          //   ),
          // ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
