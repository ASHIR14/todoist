import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/model/task.dart' as t;
import 'package:todoist/core/usecase/usecase.dart';
import 'package:todoist/features/kanban_board/services/repository/kanban_board_repository.dart';

class GetAllTasksUseCase extends UseCase<List<t.Task>, String> {
  final KanbanBoardRepository _kanbanBoardRepository;

  GetAllTasksUseCase({required KanbanBoardRepository kanbanBoardRepository})
      : _kanbanBoardRepository = kanbanBoardRepository;

  @override
  Future<Either<Failure, List<t.Task>>> call(String params) {
    return _kanbanBoardRepository.getAllTasks(params);
  }
}
