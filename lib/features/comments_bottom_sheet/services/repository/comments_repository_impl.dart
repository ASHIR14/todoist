import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/comment.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/services/network/api_path.dart';
import 'package:todoist/core/services/network/dio_wrapper.dart';
import 'package:todoist/features/comments_bottom_sheet/services/data/create_comment_params.dart';
import 'package:todoist/features/comments_bottom_sheet/services/repository/comments_repository.dart';

class CommentsRepositoryImpl extends CommentsRepository {
  final IDioWrapper _dio;

  CommentsRepositoryImpl({
    required IDioWrapper dioWrapper,
  }) : _dio = dioWrapper;

  @override
  Future<Either<Failure, List<Comment>>> getComments(String taskID) async {
    try {
      final result = await _dio.onGet(api: APIPaths.getComments(taskID));
      return Right(
          result.data.map<Comment>((e) => Comment.fromMap(e)).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment>> createComment(
      CreateCommentParams params) async {
    try {
      final result =
          await _dio.onPost(api: APIPaths.addComment, data: params.toMap());
      return Right(Comment.fromMap(result.data));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
