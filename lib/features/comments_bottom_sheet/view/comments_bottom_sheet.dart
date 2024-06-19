import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todoist/core/model/task.dart' as t;
import 'package:todoist/core/widgets/button.dart';
import 'package:todoist/core/widgets/text_field.dart';
import 'package:todoist/features/comments_bottom_sheet/services/usecases/create_comment_usecase.dart';
import 'package:todoist/features/comments_bottom_sheet/services/usecases/get_comments_usecase.dart';
import 'package:todoist/features/comments_bottom_sheet/view/comments_bottom_sheet_controller.dart';
import 'package:todoist/features/comments_bottom_sheet/widgets/comments_shimmer.dart';

class CommentsBottomSheet extends StatefulWidget {
  const CommentsBottomSheet(
      {required this.task, required this.onCommentAdded, super.key});

  final t.Task task;
  final VoidCallback onCommentAdded;

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  TextEditingController commentController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentsBottomSheetController>(
      init: CommentsBottomSheetController(
        createCommentUseCase: Get.find<CreateCommentUseCase>(),
        getCommentsUseCase: Get.find<GetCommentsUseCase>(),
        task: widget.task,
      ),
      builder: (controller) {
        return SafeArea(
          child: Container(
            height: 500.h,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Column(
              children: [
                const Divider(),
                Expanded(
                  child: controller.isLoading
                      ? const CommentsShimmer()
                      : controller.comments.isNotEmpty
                          ? ListView.separated(
                              controller: scrollController,
                              itemCount: controller.comments.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.h,
                                    horizontal: 5.w,
                                  ),
                                  child:
                                      Text(controller.comments[index].content),
                                );
                              },
                            )
                          : const Center(
                              child: Text('No comments'),
                            ),
                ),
                const Divider(),
                const SizedBox(height: 10),
                SizedBox(
                  height: 70.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: commentController,
                          hintText: 'Add a comment',
                        ),
                      ),
                      Obx(
                        () => CustomButton(
                          height: 50.h,
                          width: 50.w,
                          isIconButton: true,
                          isLoading: controller.isSendLoading.value,
                          onTap: () async {
                            if (commentController.text.trim().isNotEmpty) {
                              await controller.createComment(
                                commentController.text.trim(),
                              );
                              widget.onCommentAdded();
                              // Future.delayed(
                              //   const Duration(milliseconds: 200),
                              //   () => scrollController.animateTo(
                              //     scrollController.position.maxScrollExtent,
                              //     duration: const Duration(milliseconds: 500),
                              //     curve: Curves.ease,
                              //   ),
                              // );
                              commentController.clear();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
