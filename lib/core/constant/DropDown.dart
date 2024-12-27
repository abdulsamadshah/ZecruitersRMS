
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zecruiters_rms/core/Utils/Context_Utility.dart';
import 'package:zecruiters_rms/gen/fonts.gen.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';

import '../theme/themes_data.dart';




Widget DropdownItemBuilder({required String item}) {
  return ListTile(
    contentPadding: const EdgeInsets.all(0),
    title: Padding(
      padding: EdgeInsets.only(left: 20.w, right: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reausabletext(
            (item.toString()),
            // color: Colors.black,
            fontweight: FontWeight.w400,
            fontfamily: FontFamily.interMedium,
            fontsize: 15,
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    ),
  );
}

Widget DropdownBuilder({required String selectedItem}) {
  return reausabletext(
    selectedItem,
    fontfamily: FontFamily.interMedium,
    fontsize: 15,
  );
}

InputDecoration DropdownDecoration(
    {required String hintText, Widget? prefixIcon}) {
  return InputDecoration(
    isDense: true,
    prefixIcon: prefixIcon,
    fillColor: ContextUtility.context!.isDarkMode
        ? ToggleThemeData.backgroundBlack
        : Colors.white,
    filled: true,
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.black),
    contentPadding: EdgeInsets.only(left: 10.w, bottom: 15.h),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.r),borderSide: BorderSide(color: Colors.grey.shade200)),
  );
}

Widget DropDownItems(
    {required String? title,
      required List dropdownItems,
      void Function(String? value)? onChanged,
      String? Function(String?)? validator,
      Widget? prefixIcon,
      bool showSearchBox = true}) {
  return DropdownSearch<String>(
    popupProps: PopupProps.menu(
      showSelectedItems: true,
      showSearchBox: showSearchBox,
      searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Search..".tr,
            prefixIcon: reausableIcon(icon: Icons.search),
            border: OutlineInputBorder(

              borderRadius: BorderRadius.all(Radius.circular(50.r)),
            ),
            contentPadding: EdgeInsets.only(top: 6.h, left: 10.w, bottom: 20.h),
          )),
      itemBuilder: (context, item, isSelected) {
        return DropdownItemBuilder(item: item);
      },
    ),
    validator: validator,

    dropdownBuilder: (context, selectedItem) {
      return DropdownBuilder(
          selectedItem: selectedItem.toString() == "Select $title"
              ? title!
              : selectedItem.toString());
    },

    items: dropdownItems.map((item) => item.name.toString()).toList(),
    // items:dropdownItems.map((e) => e.name).toList();
    dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: DropdownDecoration(
        prefixIcon: prefixIcon,
        hintText: 'Select $title',
      ),
    ),
    onChanged: onChanged,

    selectedItem: "$title",
  );
}