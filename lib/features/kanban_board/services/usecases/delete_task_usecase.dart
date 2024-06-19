import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/model/task.dart' as t;
import 'package:todoist/core/usecase/usecase.dart';
import 'package:todoist/features/kanban_board/services/repository/kanban_board_repository.dart';

class DeleteTaskUseCase extends UseCase<bool, t.Task> {
  final KanbanBoardRepository _kanbanBoardRepository;

  DeleteTaskUseCase({required KanbanBoardRepository kanbanBoardRepository})
      : _kanbanBoardRepository = kanbanBoardRepository;

  @override
  Future<Either<Failure, bool>> call(t.Task params) {
    return _kanbanBoardRepository.deleteTask(params);
  }
}
