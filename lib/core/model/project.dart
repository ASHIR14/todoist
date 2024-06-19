class Project {
  final String id;
  final String name;
  final int commentCount;
  final int order;
  final String color;
  final bool isShared;
  final bool isFavorite;
  final String parentId;
  final bool isInboxProject;
  final bool isTeamInbox;
  final String viewStyle;
  final String url;

  Project({
    required this.id,
    required this.name,
    required this.commentCount,
    required this.order,
    required this.color,
    required this.isShared,
    required this.isFavorite,
    required this.parentId,
    required this.isInboxProject,
    required this.isTeamInbox,
    required this.viewStyle,
    required this.url,
  });

  Project.empty()
      : id = '',
        name = '',
        commentCount = 0,
        order = 0,
        color = '',
        isShared = false,
        isFavorite = false,
        parentId = '',
        isInboxProject = false,
        isTeamInbox = false,
        viewStyle = '',
        url = '';

  Project copyWith({
    String? id,
    String? name,
    int? commentCount,
    int? order,
    String? color,
    bool? isShared,
    bool? isFavorite,
    String? parentId,
    bool? isInboxProject,
    bool? isTeamInbox,
    String? viewStyle,
    String? url,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      commentCount: commentCount ?? this.commentCount,
      order: order ?? this.order,
      color: color ?? this.color,
      isShared: isShared ?? this.isShared,
      isFavorite: isFavorite ?? this.isFavorite,
      parentId: parentId ?? this.parentId,
      isInboxProject: isInboxProject ?? this.isInboxProject,
      isTeamInbox: isTeamInbox ?? this.isTeamInbox,
      viewStyle: viewStyle ?? this.viewStyle,
      url: url ?? this.url,
    );
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      commentCount: map['comment_count'] ?? 0,
      order: map['order'] ?? 0,
      color: map['color'] ?? '',
      isShared: map['is_shared'] ?? false,
      isFavorite: map['is_favorite'] ?? false,
      parentId: map['parent_id'] ?? '',
      isInboxProject: map['is_inbox_project'] ?? false,
      isTeamInbox: map['is_team_inbox'] ?? false,
      viewStyle: map['view_style'] ?? '',
      url: map['url'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'comment_count': commentCount,
      'order': order,
      'color': color,
      'is_shared': isShared,
      'is_favorite': isFavorite,
      'parent_id': parentId,
      'is_inbox_project': isInboxProject,
      'is_team_inbox': isTeamInbox,
      'view_style': viewStyle,
      'url': url,
    };
  }
}
