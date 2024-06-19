import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/comment.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/usecase/usecase.dart';
import 'package:todoist/features/comments_bottom_sheet/services/repository/comments_repository.dart';

class GetCommentsUseCase extends UseCase<List<Comment>, String> {
  final CommentsRepository _commentsRepository;

  GetCommentsUseCase({required CommentsRepository commentsRepository})
      : _commentsRepository = commentsRepository;

  @override
  Future<Either<Failure, List<Comment>>> call(String params) {
    return _commentsRepository.getComments(params);
  }
}
