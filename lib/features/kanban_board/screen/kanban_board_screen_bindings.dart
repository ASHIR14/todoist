import 'package:get/get.dart';
import 'package:todoist/core/services/network/dio_wrapper.dart';
import 'package:todoist/features/comments_bottom_sheet/services/repository/comments_repository.dart';
import 'package:todoist/features/comments_bottom_sheet/services/repository/comments_repository_impl.dart';
import 'package:todoist/features/comments_bottom_sheet/services/usecases/create_comment_usecase.dart';
import 'package:todoist/features/comments_bottom_sheet/services/usecases/get_comments_usecase.dart';
import 'package:todoist/features/kanban_board/screen/kanban_board_screen_controller.dart';
import 'package:todoist/features/kanban_board/services/repository/kanban_board_repository.dart';
import 'package:todoist/features/kanban_board/services/repository/kanban_board_repository_impl.dart';
import 'package:todoist/features/kanban_board/services/usecases/create_task_usecase.dart';
import 'package:todoist/features/kanban_board/services/usecases/delete_task_usecase.dart';
import 'package:todoist/features/kanban_board/services/usecases/get_all_projects_usecase.dart';
import 'package:todoist/features/kanban_board/services/usecases/get_all_tasks_usecase.dart';
import 'package:todoist/features/kanban_board/services/usecases/update_task_usecase.dart';

class KanbanBoardScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KanbanBoardRepository>(
        () => KanbanBoardRepositoryImpl(dioWrapper: Get.find<IDioWrapper>()));

    Get.lazyPut<CommentsRepository>(
        () => CommentsRepositoryImpl(dioWrapper: Get.find<IDioWrapper>()));

    Get.lazyPut<GetAllProjectsUseCase>(() => GetAllProjectsUseCase(
        kanbanBoardRepository: Get.find<KanbanBoardRepository>()));

    Get.lazyPut<GetAllTasksUseCase>(() => GetAllTasksUseCase(
        kanbanBoardRepository: Get.find<KanbanBoardRepository>()));

    Get.lazyPut<CreateTaskUseCase>(() => CreateTaskUseCase(
        kanbanBoardRepository: Get.find<KanbanBoardRepository>()));

    Get.lazyPut<UpdateTaskUseCase>(() => UpdateTaskUseCase(
        kanbanBoardRepository: Get.find<KanbanBoardRepository>()));

    Get.lazyPut<DeleteTaskUseCase>(() => DeleteTaskUseCase(
        kanbanBoardRepository: Get.find<KanbanBoardRepository>()));

    Get.lazyPut<GetCommentsUseCase>(() =>
        GetCommentsUseCase(commentsRepository: Get.find<CommentsRepository>()));

    Get.lazyPut<CreateCommentUseCase>(() => CreateCommentUseCase(
        commentsRepository: Get.find<CommentsRepository>()));

    Get.put<KanbanBoardScreenController>(KanbanBoardScreenController(
      getAllProjectsUseCase: Get.find<GetAllProjectsUseCase>(),
      getAllTasksUseCase: Get.find<GetAllTasksUseCase>(),
      createTaskUseCase: Get.find<CreateTaskUseCase>(),
      updateTaskUseCase: Get.find<UpdateTaskUseCase>(),
      deleteTaskUseCase: Get.find<DeleteTaskUseCase>(),
    ));
  }
}
