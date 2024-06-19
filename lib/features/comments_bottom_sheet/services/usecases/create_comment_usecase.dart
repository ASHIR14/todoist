import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/comment.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/usecase/usecase.dart';
import 'package:todoist/features/comments_bottom_sheet/services/data/create_comment_params.dart';
import 'package:todoist/features/comments_bottom_sheet/services/repository/comments_repository.dart';

class CreateCommentUseCase extends UseCase<Comment, CreateCommentParams> {
  final CommentsRepository _commentsRepository;

  CreateCommentUseCase({required CommentsRepository commentsRepository})
      : _commentsRepository = commentsRepository;

  @override
  Future<Either<Failure, Comment>> call(CreateCommentParams params) {
    return _commentsRepository.createComment(params);
  }
}
