class LessonEntity {
  final String title;
  final List<String> kadoIds;
  final int progress;
  final bool visible;
  final String id;

  LessonEntity(this.title, this.kadoIds, this.progress, this.visible, this.id);

  @override
  int get hashCode =>
      title.hashCode ^
      kadoIds.hashCode ^
      progress.hashCode ^
      visible.hashCode ^
      id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonEntity &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          kadoIds == other.kadoIds &&
          progress == other.progress &&
          visible == other.visible &&
          id == other.id;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'kadoIds': kadoIds,
      'progress': progress,
      'visible': visible,
      'id': id
    };
  }

  @override
  String toString() {
    return 'LessonEntity { title: $title, kadoIds: $kadoIds , progress: $progress, visible: $visible, id: $id }';
  }

  static LessonEntity fromJson(Map<String, dynamic> json) {
    return LessonEntity(
      json['title'] as String,
      List<String>.from(json['kadoIds']),
      json['progress'] as int,
      json['visible'] as bool,
      json['id'] as String,
    );
  }
}
