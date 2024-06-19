import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/comment.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/features/comments_bottom_sheet/services/data/create_comment_params.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<Comment>>> getComments(String taskID);

  Future<Either<Failure, Comment>> createComment(CreateCommentParams params);
}
