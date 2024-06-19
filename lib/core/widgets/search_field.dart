import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoist/core/widgets/text_field.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.debounceMillis = 0,
  });

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final int debounceMillis;

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  late TextEditingController _controller;
  bool _iconVisible = false;
  final double radius = 10.r;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        if (_iconVisible) {
          setState(() {
            _iconVisible = false;
          });
        }
      } else {
        if (!_iconVisible) {
          setState(() {
            _iconVisible = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: 'Search Tasks',
      controller: _controller,
      onChanged: widget.onChanged,
      debounceMillis: widget.debounceMillis,
      prefixIcon: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(vertical: 12.w, horizontal: 14.h),
        child: Icon(
          Icons.search,
          size: 20.r,
        ),
      ),
      suffixIcon: _iconVisible
          ? IconButton(
              onPressed: () {
                _controller.clear();
                setState(() {
                  _iconVisible = false;
                });
                widget.onChanged?.call('');
              },
              icon: Icon(
                Icons.close,
                size: 20.r,
              ),
            )
          : null,
    );
  }
}
