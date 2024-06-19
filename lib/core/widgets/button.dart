import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.title,
    this.onTap,
    this.isLoading = false,
    this.height,
    this.width,
    this.isIconButton = false,
    this.icon = Icons.send,
  });

  final VoidCallback? onTap;
  final String? title;
  final bool isLoading;
  final double? height;
  final double? width;
  final bool isIconButton;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(10.r),
      child: isIconButton
          ? IconButton(
              onPressed: isLoading ? () {} : onTap,
              icon: isLoading
                  ? const CircularProgressIndicator(strokeWidth: 2)
                  : Icon(icon),
            )
          : ElevatedButton(
              onPressed: isLoading ? () {} : onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                elevation: 0,
              ),
              child: isLoading
                  ? SizedBox(
                      height: 20.r,
                      width: 20.r,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      title ?? "Tap",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
            ),
    );
  }
}
