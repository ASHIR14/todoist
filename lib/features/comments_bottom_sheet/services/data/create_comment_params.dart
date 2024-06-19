class CreateCommentParams {
  final String comment;
  final String taskID;

  CreateCommentParams({
    required this.comment,
    required this.taskID,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': comment,
      'task_id': taskID,
    };
  }
}
