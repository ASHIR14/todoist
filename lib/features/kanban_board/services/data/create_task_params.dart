class CreateTaskParams {
  final String projectId;
  final String title;
  final String description;

  CreateTaskParams({
    required this.projectId,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'project_id': projectId,
      'content': title,
      'description': description,
    };
  }
}
