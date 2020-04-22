import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../repository/lessons/lesson_entity.dart';

class Lesson extends Equatable {
  final String title;
  final List<String> kadoIds;
  final String id;

  Lesson({
    @required this.title,
    @required this.kadoIds,
    String id,
  }) : this.id = id ?? Uuid().v4();


   @override
  List<Object> get props =>
      [title, kadoIds, id];

  @override
  String toString() {
    return 'Lesson { title: $title, cardIds: $kadoIds, id: $id }';
  }

  LessonEntity toEntity() {
    return LessonEntity(title, kadoIds, id);
  }

  static Lesson fromEntity(LessonEntity entity) {
    return Lesson(
      title: entity.title,
      kadoIds: entity.cardIds,
      id: entity.id ?? Uuid().v4(),
    );
  }
}