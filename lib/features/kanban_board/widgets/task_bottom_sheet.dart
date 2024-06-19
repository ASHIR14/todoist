import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todoist/core/model/task.dart';
import 'package:todoist/core/widgets/button.dart';
import 'package:todoist/core/widgets/text_field.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet(
      {this.task,
      required this.onButtonPressed,
      this.onDeleteButtonPressed,
      super.key});

  final Task? task;
  final Future<void> Function(String title, String description) onButtonPressed;
  final Future<void> Function()? onDeleteButtonPressed;

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  final RxBool isLoading = false.obs;
  final RxBool isDeleteLoading = false.obs;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.task?.content);
    descriptionController =
        TextEditingController(text: widget.task?.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 600.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.task != null ? 'Edit Task' : 'Add Task',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 20.h),
              CustomTextField(controller: titleController, hintText: 'Title *'),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: descriptionController,
                hintText: 'Description',
                maxLines: 5,
              ),
              SizedBox(height: 20.h),
              Obx(
                () => CustomButton(
                  title: widget.task != null ? 'Update' : 'Add',
                  isLoading: isLoading.value,
                  onTap: () async {
                    if (titleController.text.trim().isNotEmpty) {
                      isLoading.value = true;
                      await widget.onButtonPressed.call(
                        titleController.text.trim(),
                        descriptionController.text.trim(),
                      );
                      isLoading.value = false;
                      Get.back();
                    }
                  },
                ),
              ),
              if (widget.onDeleteButtonPressed != null)
                Obx(
                  () => CustomButton(
                    title: 'Delete',
                    isLoading: isDeleteLoading.value,
                    onTap: () async {
                      isDeleteLoading.value = true;
                      await widget.onDeleteButtonPressed!.call();
                      isDeleteLoading.value = false;
                      Get.back();
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
