import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditButton extends StatelessWidget {
  const EditButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30.h,
        width: 45.w,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Icon(Icons.edit, size: 15.sp),
      ),
    );
  }
}
