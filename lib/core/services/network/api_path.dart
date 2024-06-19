class APIPaths {
  static const String baseUrl = 'https://api.todoist.com/rest/v2/';

  static const String getAllProjects = 'projects';

  static String getAllTasks(String id) => "tasks?project_id=$id";

  static const String createTask = 'tasks';

  static String updateTask(String id) => 'tasks/$id';

  static String deleteTask(String id) => 'tasks/$id';

  static String getComments(String id) => "comments?task_id=$id";

  static const String addComment = 'comments';
}
