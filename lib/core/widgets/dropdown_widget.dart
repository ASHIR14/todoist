import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todoist/core/model/dropdown.dart';
import 'package:todoist/core/widgets/search_field.dart';

class CustomDropdownWidget extends StatelessWidget {
  final String placeholder;
  final bool singleSelection;
  final List<DropdownModel> options;
  final RxSet<DropdownModel> selected;
  final ValueChanged<Set<DropdownModel>> onSelectionChanged;

  const CustomDropdownWidget({
    super.key,
    required this.placeholder,
    required this.singleSelection,
    required this.options,
    required this.selected,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final selected = await _showBottomSheet(context);
        if (selected != null) {
          if (context.mounted) {
            onSelectionChanged(selected);
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Text(
                selected.isEmpty
                    ? placeholder
                    : selected.map((e) => e.name).join(','),
                style: TextStyle(fontSize: 16.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 4.w),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Future<Set<DropdownModel>?> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet<Set<DropdownModel>?>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        final controller = DropdownController(
          placeholder: placeholder,
          singleSelection: singleSelection,
          options: options,
          selected: selected,
        );
        return DropdownSheetContent(controller: controller);
      },
    );
  }
}

class DropdownSheetContent extends StatelessWidget {
  final DropdownController controller;

  const DropdownSheetContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DropdownController>(
        init: controller,
        builder: (controller) {
          return SafeArea(
            child: Container(
              height: 600.h,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.placeholder,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomSearchField(
                    onChanged: controller.onSearch,
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      children: controller.results
                          .map(
                            (e) => CheckboxListTile(
                              value: controller.selected
                                  .any((e2) => e2.id == e.id),
                              title: Text(
                                e.name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onChanged: (value) {
                                if (controller.singleSelection) {
                                  Navigator.pop(context, {e});
                                } else {
                                  controller.toggle(e);
                                }
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  if (!controller.singleSelection)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, controller.selected);
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }
}

class DropdownController extends GetxController {
  final String placeholder;
  final bool singleSelection;
  final List<DropdownModel> options;
  final Set<DropdownModel> selected;

  List<DropdownModel> results = [];

  DropdownController({
    required this.placeholder,
    required this.singleSelection,
    required this.options,
    required this.selected,
  });

  @override
  void onInit() {
    results.addAll(options);
    update();
    super.onInit();
  }

  void toggle(DropdownModel e) {
    if (selected.contains(e)) {
      selected.remove(e);
    } else {
      selected.add(e);
    }
    update();
  }

  void onSearch(String text) {
    results.clear();
    if (text.trim().isEmpty) {
      results.addAll(options);
      update();
      return;
    }
    results.addAll(options.where(
        (element) => element.name.toLowerCase().contains(text.toLowerCase())));
    update();
  }
}
