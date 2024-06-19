import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({this.onTap, this.isPlay = false, super.key});

  final VoidCallback? onTap;
  final bool isPlay;

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
          isPlay ? Icons.stop : Icons.play_arrow,
          size: 18.sp,
        ),
      ),
    );
  }
}
