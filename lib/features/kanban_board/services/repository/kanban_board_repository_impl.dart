import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/model/project.dart';
import 'package:todoist/core/model/task.dart' as t;
import 'package:todoist/core/services/network/api_path.dart';
import 'package:todoist/core/services/network/dio_wrapper.dart';
import 'package:todoist/features/kanban_board/services/data/create_task_params.dart';
import 'package:todoist/features/kanban_board/services/repository/kanban_board_repository.dart';

class KanbanBoardRepositoryImpl extends KanbanBoardRepository {
  final IDioWrapper _dio;

  KanbanBoardRepositoryImpl({
    required IDioWrapper dioWrapper,
  }) : _dio = dioWrapper;

  @override
  Future<Either<Failure, List<Project>>> getAllProjects() async {
    try {
      final result = await _dio.onGet(api: APIPaths.getAllProjects);
      return Right(
          result.data.map<Project>((e) => Project.fromMap(e)).toList());
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<t.Task>>> getAllTasks(String projectID) async {
    try {
      final result = await _dio.onGet(api: APIPaths.getAllTasks(projectID));
      return Right(result.data.map<t.Task>((e) => t.Task.fromMap(e)).toList());
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, t.Task>> createTask(CreateTaskParams params) async {
    try {
      final result =
          await _dio.onPost(api: APIPaths.createTask, data: params.toMap());
      return Right(t.Task.fromMap(result.data));
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, t.Task>> updateTask(t.Task task) async {
    try {
      final result = await _dio.onPost(
          api: APIPaths.updateTask(task.id), data: task.toMap());
      return Right(t.Task.fromMap(result.data));
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTask(t.Task task) async {
    try {
      await _dio.onDelete(api: APIPaths.deleteTask(task.id));
      return const Right(true);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
