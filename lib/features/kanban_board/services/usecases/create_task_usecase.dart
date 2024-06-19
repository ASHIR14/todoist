import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/model/task.dart' as t;
import 'package:todoist/core/usecase/usecase.dart';
import 'package:todoist/features/kanban_board/services/data/create_task_params.dart';
import 'package:todoist/features/kanban_board/services/repository/kanban_board_repository.dart';

class CreateTaskUseCase extends UseCase<t.Task, CreateTaskParams> {
  final KanbanBoardRepository _kanbanBoardRepository;

  CreateTaskUseCase({required KanbanBoardRepository kanbanBoardRepository})
      : _kanbanBoardRepository = kanbanBoardRepository;

  @override
  Future<Either<Failure, t.Task>> call(CreateTaskParams params) {
    return _kanbanBoardRepository.createTask(params);
  }
}
