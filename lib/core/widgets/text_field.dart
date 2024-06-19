import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoist/utils/fonts/font_utils.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.readOnly,
    this.debounceMillis = 0,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool? readOnly;
  final int debounceMillis;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Timer? _debounceTimer;
  late TextEditingController _controller;
  final double radius = 10.r;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.all(10.r),
      child: TextFormField(
        controller: _controller,
        textInputAction: TextInputAction.done,
        onChanged: (text) {
          if (widget.debounceMillis == 0) {
            widget.onChanged?.call(text);
          } else {
            _debounceTimer?.cancel();
            _debounceTimer =
                Timer(Duration(milliseconds: widget.debounceMillis), () {
              widget.onChanged?.call(text);
            });
          }
        },
        readOnly: widget.readOnly ?? false,
        maxLines: widget.maxLines,
        cursorColor: colorTheme.tertiary.withOpacity(0.6),
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: FontUtils.getSecondaryFont(),
          fontStyle: FontStyle.normal,
          fontSize: 14.sp,
          color: colorTheme.tertiary,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsetsDirectional.symmetric(
            vertical: 10.h,
            horizontal: 10.w,
          ),
          hintStyle: TextStyle(
            color: colorTheme.surfaceVariant.withOpacity(0.6),
            fontSize: 14.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}
