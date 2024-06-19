import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/model/project.dart';
import 'package:todoist/core/model/task.dart' as t;
import 'package:todoist/features/kanban_board/services/data/create_task_params.dart';

abstract class KanbanBoardRepository {
  Future<Either<Failure, List<Project>>> getAllProjects();

  Future<Either<Failure, List<t.Task>>> getAllTasks(String projectID);

  Future<Either<Failure, t.Task>> createTask(CreateTaskParams params);

  Future<Either<Failure, t.Task>> updateTask(t.Task task);

  Future<Either<Failure, bool>> deleteTask(t.Task task);
}
