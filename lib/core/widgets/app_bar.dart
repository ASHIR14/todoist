import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todoist/routes/app_routes.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    super.key,
  });

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 56.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (leading != null) leading!,
            Expanded(
              child: Center(
                child: Text(
                  title ?? '',
                  textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions ??
                  [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Get.toNamed(Routes.settingsScreen);
                      },
                    ),
                  ],
            ),
          ],
        ),
      ),
    );
  }
}
