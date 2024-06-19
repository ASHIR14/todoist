import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoist/core/model/task.dart';
import 'package:todoist/core/widgets/app_bar.dart';
import 'package:todoist/core/widgets/dropdown_widget.dart';
import 'package:todoist/core/widgets/search_field.dart';
import 'package:todoist/core/widgets/task_card/task_card.dart';
import 'package:todoist/features/comments_bottom_sheet/view/comments_bottom_sheet.dart';
import 'package:todoist/features/kanban_board/screen/kanban_board_screen_controller.dart';
import 'package:todoist/features/kanban_board/widgets/kanban_board_shimmer.dart';
import 'package:todoist/features/kanban_board/widgets/task_bottom_sheet.dart';
import 'package:todoist/utils/enum/task_status.dart';

class KanbanBoardScreen extends GetView<KanbanBoardScreenController> {
  const KanbanBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Obx(
              () => CustomAppBar(
                leading: CustomDropdownWidget(
                  placeholder: 'Select Project',
                  singleSelection: true,
                  options: controller.projectDropdownItems,
                  selected: controller.selectedProject,
                  onSelectionChanged: controller.updateSelectedProject,
                ),
              ),
            ),
            CustomSearchField(
              onChanged: (value) {
                // controller.search(value);
              },
            ),
            const TabBar(
              tabs: [
                Tab(text: 'Todo'),
                Tab(text: 'In Progress'),
                Tab(text: 'Completed'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  getColumnView(TaskStatus.todo),
                  getColumnView(TaskStatus.inProgress),
                  getColumnView(TaskStatus.completed),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget getColumnView(TaskStatus taskStatus) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getAllTasks();
      },
      child: Obx(
        () => controller.tasksLoading.value
            ? const KanbanBoardShimmer()
            : controller.getTasksLength(taskStatus) == 0
                ? emptyView()
                : ListView.builder(
                    itemCount: controller.getTasksLength(taskStatus),
                    itemBuilder: (context, index) {
                      final Task task =
                          controller.getTaskList(taskStatus)[index];
                      return TaskCard(
                        task: task,
                        onEdit: () => _showTaskBottomSheet(context, task: task),
                        onComment: () =>
                            _showCommentsBottomSheet(context, task),
                        onMoveBackward:
                            controller.canTaskMove(taskStatus, false)
                                ? () => controller.moveTask(
                                      task,
                                      isPromotion: false,
                                    )
                                : null,
                        onMoveForward: controller.canTaskMove(taskStatus, true)
                            ? () => controller.moveTask(task)
                            : null,
                        onPlayPause: () => controller.playPauseTimer(task),
                        isPlay: controller.timerTask.id == task.id,
                      );
                    },
                  ),
      ),
    );
  }

  Widget emptyView() {
    return const Center(
      child: Text('No tasks found'),
    );
  }

  Future<void> _showTaskBottomSheet(BuildContext context, {Task? task}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return TaskBottomSheet(
          task: task,
          onButtonPressed: (String title, String description) async {
            if (task != null) {
              await controller.updateTask(task.copyWith(
                content: title,
                description: description,
              ));
            } else {
              await controller.createNewTask(title, description);
            }
          },
          onDeleteButtonPressed: task != null
              ? () async {
                  await controller.deleteTask(task);
                }
              : null,
        );
      },
    );
  }

  Future<void> _showCommentsBottomSheet(BuildContext context, Task task) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return CommentsBottomSheet(
          task: task,
          onCommentAdded: () => controller.incrementCommentNumberLocally(task),
        );
      },
    );
  }
}
