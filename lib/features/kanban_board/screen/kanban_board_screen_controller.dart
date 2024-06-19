import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todoist/core/model/dropdown.dart';
import 'package:todoist/core/model/project.dart';
import 'package:todoist/core/model/task.dart';
import 'package:todoist/core/usecase/usecase.dart';
import 'package:todoist/features/kanban_board/services/data/create_task_params.dart';
import 'package:todoist/features/kanban_board/services/usecases/create_task_usecase.dart';
import 'package:todoist/features/kanban_board/services/usecases/delete_task_usecase.dart';
import 'package:todoist/features/kanban_board/services/usecases/get_all_projects_usecase.dart';
import 'package:todoist/features/kanban_board/services/usecases/get_all_tasks_usecase.dart';
import 'package:todoist/features/kanban_board/services/usecases/update_task_usecase.dart';
import 'package:todoist/utils/enum/task_status.dart';
import 'package:todoist/utils/loading/easyloading_utils.dart';
import 'package:todoist/utils/timer/timer_utils.dart';

class KanbanBoardScreenController extends GetxController {
  final GetAllProjectsUseCase getAllProjectsUseCase;
  final GetAllTasksUseCase getAllTasksUseCase;
  final CreateTaskUseCase createTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  RxBool isLoading = false.obs;
  RxBool tasksLoading = false.obs;

  RxList<Project> projects = <Project>[].obs;
  RxSet<DropdownModel> selectedProject = <DropdownModel>{}.obs;

  RxList<Task> todoTasks = <Task>[].obs;
  RxList<Task> inProgressTasks = <Task>[].obs;
  RxList<Task> completedTasks = <Task>[].obs;

  Task timerTask = Task.empty();

  KanbanBoardScreenController({
    required this.getAllProjectsUseCase,
    required this.getAllTasksUseCase,
    required this.createTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  });

  @override
  void onInit() {
    getAllProjects();
    customizeLoading(Get.context!);
    super.onInit();
  }

  /// -------------------- Projects -------------------- ///
  Future<void> getAllProjects() async {
    isLoading.value = true;
    final result = await getAllProjectsUseCase(NoParams());
    result.fold((left) {
      isLoading.value = false;
      log("Error [getAllProjects]: ${left.message}");
      Get.snackbar("Error", left.message);
    }, (right) {
      projects.value = right;
      if (projects.isNotEmpty) {
        Project project = projects.first;
        if (projects.length > 1) {
          project = projects
              .firstWhere((element) => element.name.toLowerCase() != "inbox");
        }
        updateSelectedProject({DropdownModel.fromProject(project)});
      }
      isLoading.value = false;
    });
  }

  List<DropdownModel> get projectDropdownItems {
    return projects.map((e) => DropdownModel.fromProject(e)).toList();
  }

  void updateSelectedProject(Set<DropdownModel> selected) {
    selectedProject.clear();
    selectedProject.addAll(selected);
    getAllTasks();
  }

  /// -------------------- Tasks -------------------- ///
  Future<void> getAllTasks() async {
    tasksLoading.value = true;
    final result = await getAllTasksUseCase(selectedProject.first.id);
    result.fold((left) {
      tasksLoading.value = false;
      log("Error [getAllTasks]: ${left.message}");
      Get.snackbar("Error", left.message);
    }, (right) {
      todoTasks.clear();
      inProgressTasks.clear();
      completedTasks.clear();
      for (final task in right) {
        if (task.status == TaskStatus.completed) {
          completedTasks.add(task);
        } else if (task.status == TaskStatus.inProgress) {
          inProgressTasks.add(task);
        } else {
          todoTasks.add(task);
        }
      }
      tasksLoading.value = false;
    });
  }

  Future<void> createNewTask(String title, String description) async {
    EasyLoading.show();
    final result = await createTaskUseCase(CreateTaskParams(
      projectId: selectedProject.first.id,
      title: title,
      description: description,
    ));
    result.fold((left) {
      EasyLoading.dismiss();
      log("Error [createNewTask]: ${left.message}");
      Get.snackbar("Error", left.message);
    }, (right) {
      todoTasks.add(right);
      EasyLoading.dismiss();
    });
  }

  Future<void> deleteTask(Task task) async {
    EasyLoading.show();
    final result = await deleteTaskUseCase(task);
    result.fold((left) {
      EasyLoading.dismiss();
      log("Error [deleteTask]: ${left.message}");
      Get.snackbar("Error", left.message);
    }, (right) {
      final int index = getTaskList(task.status)
          .indexWhere((element) => element.id == task.id);
      if (index >= 0) {
        getTaskList(task.status).removeAt(index);
      }
      EasyLoading.dismiss();
    });
  }

  Future<void> updateTask(Task task, {Task? oldTask}) async {
    EasyLoading.show();
    final result = await updateTaskUseCase(task);
    result.fold((left) {
      EasyLoading.dismiss();
      log("Error [updateTask]: ${left.message}");
      Get.snackbar("Error", left.message);
    }, (right) {
      if (oldTask != null) {
        final int index = getTaskList(oldTask.status)
            .indexWhere((element) => element.id == oldTask.id);
        if (index >= 0) {
          getTaskList(oldTask.status).removeAt(index);
        }
        getTaskList(right.status).add(right);
      } else {
        final int index = getTaskList(right.status)
            .indexWhere((element) => element.id == right.id);
        if (index >= 0) {
          getTaskList(right.status)[index] = right;
        }
      }
      EasyLoading.dismiss();
    });
  }

  Future<void> moveTask(Task task, {bool isPromotion = true}) async {
    if (TimerUtils.isTimerOn()) {
      await playPauseTimer(task);
    }
    TaskStatus newStatus = getNewStatus(task.status, isPromotion);
    List<String> labels = setLabelsList(task.labels, newStatus);
    Task updatedTask = task.copyWith(
      status: newStatus,
      labels: labels,
      isCompleted: newStatus == TaskStatus.completed,
    );
    if (isPromotion && newStatus == TaskStatus.completed) {
      updatedTask = updatedTask.copyWith(
        due: updatedTask.due.copyWith(
          datetime: DateTime.now().toIso8601String(),
        ),
      );
    }
    await updateTask(updatedTask, oldTask: task);
    Get.snackbar("Success", "Task Moved");
  }

  TaskStatus getNewStatus(TaskStatus taskStatus, bool isPromotion) {
    if (isPromotion) {
      if (taskStatus == TaskStatus.todo) {
        return TaskStatus.inProgress;
      } else if (taskStatus == TaskStatus.inProgress) {
        return TaskStatus.completed;
      }
    } else {
      if (taskStatus == TaskStatus.inProgress) {
        return TaskStatus.todo;
      } else if (taskStatus == TaskStatus.completed) {
        return TaskStatus.inProgress;
      }
    }
    return taskStatus;
  }

  List<String> setLabelsList(List<String> labels, TaskStatus taskStatus) {
    switch (taskStatus) {
      case TaskStatus.todo:
        labels.remove(TaskStatus.inProgress.name);
        labels.remove(TaskStatus.completed.name);
        labels.add(TaskStatus.todo.name);
        break;
      case TaskStatus.inProgress:
        labels.remove(TaskStatus.todo.name);
        labels.remove(TaskStatus.completed.name);
        labels.add(TaskStatus.inProgress.name);
        break;
      case TaskStatus.completed:
        labels.remove(TaskStatus.todo.name);
        labels.remove(TaskStatus.inProgress.name);
        labels.add(TaskStatus.completed.name);
        break;
    }
    return labels;
  }

  bool canTaskMove(TaskStatus taskStatus, bool isPromotion) {
    if (isPromotion) {
      return taskStatus != TaskStatus.completed;
    } else {
      return taskStatus != TaskStatus.todo;
    }
  }

  RxList<Task> getTaskList(TaskStatus taskStatus) {
    switch (taskStatus) {
      case TaskStatus.todo:
        return todoTasks;
      case TaskStatus.inProgress:
        return inProgressTasks;
      case TaskStatus.completed:
        return completedTasks;
    }
  }

  int getTasksLength(TaskStatus taskStatus) {
    switch (taskStatus) {
      case TaskStatus.todo:
        return todoTasks.length;
      case TaskStatus.inProgress:
        return inProgressTasks.length;
      case TaskStatus.completed:
        return completedTasks.length;
    }
  }

  /// -------------------- Comments -------------------- ///
  void incrementCommentNumberLocally(Task task) {
    final int index =
        getTaskList(task.status).indexWhere((element) => element.id == task.id);
    if (index >= 0) {
      final Task taskFromList = getTaskList(task.status)[index];
      final Task updatedTask =
          taskFromList.copyWith(commentCount: taskFromList.commentCount + 1);
      getTaskList(task.status)[index] = updatedTask;
    }
  }

  /// -------------------- Timer -------------------- ///
  Future<void> playPauseTimer(Task task) async {
    bool shouldStart = false;
    if (TimerUtils.isTimerOn()) {
      if (timerTask.duration.amount > 0) {
        await updateTask(timerTask);
      }
      TimerUtils.stop();
      if (timerTask.id != task.id) {
        shouldStart = true;
      }
      timerTask = Task.empty();
    } else {
      shouldStart = true;
    }
    if (shouldStart) {
      final int index =
          inProgressTasks.indexWhere((element) => element.id == task.id);
      if (index >= 0) {
        inProgressTasks[index] = inProgressTasks[index].copyWith(
            duration: Duration(amount: inProgressTasks[index].duration.amount));
        timerTask = inProgressTasks[index];
      }
      TimerUtils.start(
        startFrom: task.duration.amount * 60,
        onTickCallback: (elapsedTime) {
          inProgressTasks[index] = inProgressTasks[index].copyWith(
              duration: Duration(
                  amount: TimerUtils.secondsToRoundedMinutes(elapsedTime)));
          timerTask = inProgressTasks[index];
        },
      );
    }
  }
}
