import 'package:todoist/utils/enum/task_status.dart';

class Task {
  final String creatorId;
  final String createdAt;
  final String assigneeId;
  final String assignerId;
  final int commentCount;
  final bool isCompleted;
  final String content;
  final String description;
  final Due due;
  final Duration duration;
  final String id;
  final List<String> labels;
  final int order;
  final int priority;
  final String projectId;
  final String sectionId;
  final String parentId;
  final String url;
  final TaskStatus status;

  Task({
    required this.creatorId,
    required this.createdAt,
    required this.assigneeId,
    required this.assignerId,
    required this.commentCount,
    required this.isCompleted,
    required this.content,
    required this.description,
    required this.due,
    required this.duration,
    required this.id,
    required this.labels,
    required this.order,
    required this.priority,
    required this.projectId,
    required this.sectionId,
    required this.parentId,
    required this.url,
    this.status = TaskStatus.todo,
  });

  Task.empty()
      : creatorId = '',
        createdAt = '',
        assigneeId = '',
        assignerId = '',
        commentCount = 0,
        isCompleted = false,
        content = '',
        description = '',
        due = Due.empty(),
        duration = Duration.empty(),
        id = '',
        labels = [],
        order = 0,
        priority = 0,
        projectId = '',
        sectionId = '',
        parentId = '',
        url = '',
        status = TaskStatus.todo;

  Task copyWith({
    String? creatorId,
    String? createdAt,
    String? assigneeId,
    String? assignerId,
    int? commentCount,
    bool? isCompleted,
    String? content,
    String? description,
    Due? due,
    Duration? duration,
    String? id,
    List<String>? labels,
    int? order,
    int? priority,
    String? projectId,
    String? sectionId,
    String? parentId,
    String? url,
    TaskStatus? status,
  }) {
    return Task(
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      assigneeId: assigneeId ?? this.assigneeId,
      assignerId: assignerId ?? this.assignerId,
      commentCount: commentCount ?? this.commentCount,
      isCompleted: isCompleted ?? this.isCompleted,
      content: content ?? this.content,
      description: description ?? this.description,
      due: due ?? this.due,
      duration: duration ?? this.duration,
      id: id ?? this.id,
      labels: labels ?? this.labels,
      order: order ?? this.order,
      priority: priority ?? this.priority,
      projectId: projectId ?? this.projectId,
      sectionId: sectionId ?? this.sectionId,
      parentId: parentId ?? this.parentId,
      url: url ?? this.url,
      status: status ?? this.status,
    );
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    Task task = Task(
      creatorId: map['creator_id'] ?? '',
      createdAt: map['created_at'] ?? '',
      assigneeId: map['assignee_id'] ?? '',
      assignerId: map['assigner_id'] ?? '',
      commentCount: map['comment_count'] ?? 0,
      isCompleted: map['is_completed'] ?? false,
      content: map['content'] ?? '',
      description: map['description'] ?? '',
      due: Due.fromMap(map['due'] ?? {}),
      duration: Duration.fromMap(map['duration'] ?? {}),
      id: map['id'] ?? '',
      labels: List<String>.from(map['labels'] ?? []),
      order: map['order'] ?? 0,
      priority: map['priority'] ?? 0,
      projectId: map['project_id'] ?? '',
      sectionId: map['section_id'] ?? '',
      parentId: map['parent_id'] ?? '',
      url: map['url'] ?? '',
    );
    TaskStatus status = TaskStatus.todo;
    if (task.isCompleted || task.labels.contains(TaskStatus.completed.name)) {
      status = TaskStatus.completed;
    } else if (task.labels.contains(TaskStatus.inProgress.name)) {
      status = TaskStatus.inProgress;
    }
    return task.copyWith(status: status);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'is_completed': isCompleted,
      'content': content,
      'description': description,
      'labels': labels,
      'project_id': projectId,
    };
    if (duration.amount > 0) {
      map['duration'] = duration.amount;
      map['duration_unit'] = duration.unit;
    }
    if (due.datetime.isNotEmpty) {
      map['due_datetime'] = due.datetime;
    }
    return map;
  }
}

class Due {
  final String date;
  final bool isRecurring;
  final String datetime;
  final String string;
  final String timezone;

  Due({
    required this.date,
    required this.isRecurring,
    required this.datetime,
    required this.string,
    required this.timezone,
  });

  Due.empty()
      : date = '',
        isRecurring = false,
        datetime = '',
        string = '',
        timezone = '';

  Due copyWith({
    String? date,
    bool? isRecurring,
    String? datetime,
    String? string,
    String? timezone,
  }) {
    return Due(
      date: date ?? this.date,
      isRecurring: isRecurring ?? this.isRecurring,
      datetime: datetime ?? this.datetime,
      string: string ?? this.string,
      timezone: timezone ?? this.timezone,
    );
  }

  factory Due.fromMap(Map<String, dynamic> map) {
    return Due(
      date: map['date'] ?? '',
      isRecurring: map['is_recurring'] ?? false,
      datetime: map['datetime'] ?? '',
      string: map['string'] ?? '',
      timezone: map['timezone'] ?? '',
    );
  }

  Map<String, dynamic>? toMap() {
    return date.isNotEmpty
        ? {
            'date': date,
            'is_recurring': isRecurring,
            'datetime': datetime,
            'string': string,
            'timezone': timezone,
          }
        : null;
  }
}

class Duration {
  final int amount;
  final String unit;

  Duration({
    required this.amount,
    this.unit = 'minute',
  });

  Duration.empty()
      : amount = 0,
        unit = 'minute';

  factory Duration.fromMap(Map<String, dynamic> map) {
    return Duration(
      amount: map['amount'] ?? 0,
      unit: map['unit'] ?? 'minute',
    );
  }

  Map<String, dynamic>? toMap() {
    return amount > 0
        ? {
            'amount': amount,
            'unit': unit,
          }
        : null;
  }

  @override
  String toString() {
    return '$amount ${unit + (amount != 1 ? 's' : '')}';
  }
}
