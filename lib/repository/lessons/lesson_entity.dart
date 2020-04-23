import 'dart:convert';

class LessonEntity {
  final String title;
  final List<String> kadoIds;
  final int progress;
  final String id;

  LessonEntity(this.title, this.kadoIds, this.progress, this.id);

  @override
  int get hashCode =>
      title.hashCode ^
      kadoIds.hashCode ^
      progress.hashCode ^
      id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonEntity &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          kadoIds == other.kadoIds &&
          progress == other.progress &&
          id == other.id;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'kadoIds': kadoIds,
      'progress': progress,
      'id': id
    };
  }

  @override
  String toString() {
    return 'LessonEntity { title: $title, kadoIds: $kadoIds , progress: $progress, id: $id }';
  }

  static LessonEntity fromJson(Map<String, dynamic> json) {
    return LessonEntity(
      json['title'] as String,
      List<String>.from(json['kadoIds']),
      json['progress'] as int,
      json['id'] as String,
    );
  }
}
