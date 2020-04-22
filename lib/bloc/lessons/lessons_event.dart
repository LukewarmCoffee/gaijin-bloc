import 'package:equatable/equatable.dart';

import '../../models/lesson.dart';

abstract class LessonsEvent extends Equatable {
  const LessonsEvent();

  @override
  List<Object> get props => [];
}

class LoadLessons extends LessonsEvent {}

class AddLesson extends LessonsEvent {
  final Lesson lesson;

  const AddLesson(this.lesson);

  @override
  List<Object> get props => [lesson];

  @override
  String toString() => 'AddLesson { lesson: $lesson }';
}

class UpdateLesson extends LessonsEvent {
  final Lesson updatedLesson;

  const UpdateLesson(this.updatedLesson);

  @override
  String toString() => 'UpdateLesson { updatedLesson: $updatedLesson }';
}

class DeleteLesson extends LessonsEvent {
  final Lesson lesson;

  const DeleteLesson(this.lesson);

  @override
  List<Object> get props => [lesson];

  @override
  String toString() => 'DeleteLesson { lesson: $lesson }';
}