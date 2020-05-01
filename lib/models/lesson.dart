import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../repository/lessons/lesson_entity.dart';

class Lesson extends Equatable {
  final String title;
  final List<String> kadoIds;
  final int progress;
  final bool visible; //TODO deprecated
  final String id;

  Lesson({
    @required this.title,
    @required this.kadoIds,
    int progress = 0,
    bool visible = false,
    String id,
  })  : this.progress = progress ?? 0,
        this.visible = visible ?? false,
        this.id = id ?? Uuid().v4();

  Lesson copyWith(
      {String title,
      List<String> kadoIds,
      int progress,
      bool visible,
      String id}) {
    return Lesson(
      title: title ?? this.title,
      kadoIds: kadoIds ?? this.kadoIds,
      progress: progress ?? this.progress,
      visible: visible ?? this.visible,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [title, kadoIds, progress, visible, id];

  @override
  String toString() {
    return 'Lesson { title: $title, kadoIds: $kadoIds , progress: $progress, visible: $visible, id: $id }';
  }

  LessonEntity toEntity() {
    return LessonEntity(title, kadoIds, progress, visible, id);
  }

  static Lesson fromEntity(LessonEntity entity) {
    return Lesson(
      title: entity.title,
      kadoIds: entity.kadoIds,
      progress: entity.progress ?? 0,
      visible: entity.visible ?? false,
      id: entity.id ?? Uuid().v4(),
    );
  }
}
