import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/model/task.dart' as t;
import 'package:todoist/core/usecase/usecase.dart';
import 'package:todoist/features/kanban_board/services/repository/kanban_board_repository.dart';

class UpdateTaskUseCase extends UseCase<t.Task, t.Task> {
  final KanbanBoardRepository _kanbanBoardRepository;

  UpdateTaskUseCase({required KanbanBoardRepository kanbanBoardRepository})
      : _kanbanBoardRepository = kanbanBoardRepository;

  @override
  Future<Either<Failure, t.Task>> call(t.Task params) {
    return _kanbanBoardRepository.updateTask(params);
  }
}
