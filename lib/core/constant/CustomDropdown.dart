import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/RemakListRes.dart';
import '../theme/themes_data.dart';


class CustomDropdown extends StatelessWidget {
  final List<RemakListData> items;
  final String hintText;
  final RemakListData? selectedItem;
  final Function(RemakListData?) onChanged;
  final bool showSearchBox;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.hintText,
    this.selectedItem,
    required this.onChanged,
    this.showSearchBox = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 10.w),
        child: DropdownSearch<RemakListData>(
          popupProps: PopupProps.menu(
            showSearchBox: showSearchBox,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: "Search Remark",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  borderSide: const BorderSide(
                    color: ToggleThemeData.Appcolor,
                    width: 1,
                  ),
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            showSelectedItems: true,
            menuProps: MenuProps(
              borderRadius: BorderRadius.circular(10.r),
            ),
            itemBuilder: (context, item, isSelected) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      item.remarks ?? "Unknown",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: isSelected
                            ? ToggleThemeData.Appcolor
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    tileColor: isSelected
                        ? ToggleThemeData.Appcolor.withOpacity(0.2)
                        : null,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    height: 1,
                  ),
                ],
              );
            },
          ),
          items: items,
          selectedItem: selectedItem,
          compareFn: (a, b) => a.id == b.id,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              border: InputBorder.none,
            ),
          ),
          dropdownBuilder: (context, selectedItem) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                selectedItem?.remarks ?? hintText,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            );
          },
          onChanged: onChanged,
        ),
      ),
    );
  }
}
