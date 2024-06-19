import 'dart:developer';

import 'package:get/get.dart';
import 'package:todoist/core/model/comment.dart';
import 'package:todoist/core/model/task.dart';
import 'package:todoist/features/comments_bottom_sheet/services/data/create_comment_params.dart';
import 'package:todoist/features/comments_bottom_sheet/services/usecases/create_comment_usecase.dart';
import 'package:todoist/features/comments_bottom_sheet/services/usecases/get_comments_usecase.dart';

class CommentsBottomSheetController extends GetxController {
  final CreateCommentUseCase createCommentUseCase;
  final GetCommentsUseCase getCommentsUseCase;

  late final Task task;

  bool isLoading = false;
  RxBool isSendLoading = false.obs;
  List<Comment> comments = [];

  CommentsBottomSheetController({
    required this.createCommentUseCase,
    required this.getCommentsUseCase,
    required this.task,
  });

  @override
  void onInit() {
    getAllComments(task.id);
    super.onInit();
  }

  Future<void> getAllComments(String taskID) async {
    isLoading = true;
    final result = await getCommentsUseCase(taskID);
    result.fold((left) {
      isLoading = false;
      log("Error [getAllComments]: ${left.message}");
      Get.snackbar("Error", left.message);
    }, (right) {
      comments = right;
      isLoading = false;
      update();
    });
  }

  Future<void> createComment(String comment) async {
    isSendLoading.value = true;
    final result = await createCommentUseCase(
        CreateCommentParams(comment: comment, taskID: task.id));
    result.fold((left) {
      isSendLoading.value = false;
      log("Error [createComment]: ${left.message}");
      Get.snackbar("Error", left.message);
    }, (right) {
      comments.add(right);
      isSendLoading.value = false;
      update();
    });
  }

  @override
  void dispose() {
    comments.clear();
    super.dispose();
  }
}
