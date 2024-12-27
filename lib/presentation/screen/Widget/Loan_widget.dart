import 'package:flutter/material.dart';

Widget buildNavItem({
  required IconData icon,
  required String label,
  required bool isSelected,
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: isSelected ? 28 : 24,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: isSelected ? 14 : 12,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    ),
  );
}
