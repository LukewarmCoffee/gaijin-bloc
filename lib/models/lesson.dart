import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../repository/lessons/lesson_entity.dart';

class Lesson extends Equatable {
  final String title;
  final List<String> kadoIds;
  final String id;
  final int progress;

  Lesson({
    @required this.title,
    @required this.kadoIds,
    int progress = 0,
    String id,
  }) : this.progress = progress ?? 0, 
  this.id = id ?? Uuid().v4();

  Lesson copyWith({String title, List<String> kadoIds, int progress, String id}) {
    return Lesson(
      title: title ?? this.title,
      kadoIds: kadoIds ?? this.kadoIds,
      id: id ?? this.id,
      progress: progress ?? this.progress,
    );
  }

   @override
  List<Object> get props =>
      [title, kadoIds, progress, id];

  @override
  String toString() {
    return 'Lesson { title: $title, kadoIds: $kadoIds , progress: $progress, id: $id }';
  }

  LessonEntity toEntity() {
    return LessonEntity(title, kadoIds, progress, id);
  }

  static Lesson fromEntity(LessonEntity entity) {
    return Lesson(
      title: entity.title,
      kadoIds: entity.kadoIds,
      progress: entity.progress ?? 0,
      id: entity.id ?? Uuid().v4(),
    );
  }
}