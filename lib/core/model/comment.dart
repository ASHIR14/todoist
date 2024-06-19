class Comment {
  final String content;
  final String id;
  final String postedAt;
  final String? projectId;
  final String taskId;
  final Attachment? attachment;

  Comment({
    required this.content,
    required this.id,
    required this.postedAt,
    this.projectId,
    required this.taskId,
    this.attachment,
  });

  Comment.empty()
      : content = '',
        id = '',
        postedAt = '',
        projectId = null,
        taskId = '',
        attachment = null;

  Comment copyWith({
    String? content,
    String? id,
    String? postedAt,
    String? projectId,
    String? taskId,
    Attachment? attachment,
  }) {
    return Comment(
      content: content ?? this.content,
      id: id ?? this.id,
      postedAt: postedAt ?? this.postedAt,
      projectId: projectId ?? this.projectId,
      taskId: taskId ?? this.taskId,
      attachment: attachment ?? this.attachment,
    );
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      content: map['content'] ?? '',
      id: map['id'] ?? '',
      postedAt: map['posted_at'] ?? '',
      projectId: map['project_id'],
      taskId: map['task_id'] ?? '',
      attachment: map['attachment'] != null ? Attachment.fromMap(map['attachment']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'id': id,
      'posted_at': postedAt,
      'project_id': projectId,
      'task_id': taskId,
      'attachment': attachment?.toMap(),
    };
  }
}

class Attachment {
  final String fileName;
  final String fileType;
  final String fileUrl;
  final String resourceType;

  Attachment({
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
    required this.resourceType,
  });

  factory Attachment.fromMap(Map<String, dynamic> map) {
    return Attachment(
      fileName: map['file_name'] ?? '',
      fileType: map['file_type'] ?? '',
      fileUrl: map['file_url'] ?? '',
      resourceType: map['resource_type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'file_name': fileName,
      'file_type': fileType,
      'file_url': fileUrl,
      'resource_type': resourceType,
    };
  }
}
