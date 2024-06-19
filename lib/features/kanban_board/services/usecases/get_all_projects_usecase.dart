import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/model/project.dart';
import 'package:todoist/core/usecase/usecase.dart';
import 'package:todoist/features/kanban_board/services/repository/kanban_board_repository.dart';

class GetAllProjectsUseCase extends UseCase<List<Project>, NoParams> {
  final KanbanBoardRepository _kanbanBoardRepository;

  GetAllProjectsUseCase({required KanbanBoardRepository kanbanBoardRepository})
      : _kanbanBoardRepository = kanbanBoardRepository;

  @override
  Future<Either<Failure, List<Project>>> call(NoParams params) {
    return _kanbanBoardRepository.getAllProjects();
  }
}
