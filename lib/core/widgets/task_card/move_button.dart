import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoveButton extends StatelessWidget {
  const MoveButton({this.onTap, this.isForward = true, super.key});

  final VoidCallback? onTap;
  final bool isForward;

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
        child: Icon(
          isForward ? Icons.arrow_forward : Icons.arrow_back,
          size: 15.sp,
        ),
      ),
    );
  }
}
