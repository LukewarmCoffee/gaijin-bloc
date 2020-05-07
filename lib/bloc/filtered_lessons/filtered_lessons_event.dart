import 'package:equatable/equatable.dart';

import '../../models/lesson.dart';

abstract class FilteredLessonsEvent extends Equatable {
  const FilteredLessonsEvent();

  @override
  List<Object> get props => [];
}

class UpdateLessons extends FilteredLessonsEvent {
  final List<Lesson> lessons;

  const UpdateLessons(this.lessons);

  @override
  List<Object> get props => [lessons];

  @override
  String toString() => 'UpdateLessons { lessons: $lessons }';
}

class UpdateCreateReviewKados extends FilteredLessonsEvent{
  final List<String> kadoIds;

  const UpdateCreateReviewKados(this.kadoIds);

  @override
  List<Object> get props => [kadoIds];

  @override
  String toString() => 'UpdateKadoIds { kadoIds: $kadoIds }';
}

class LoadFilteredLessons extends FilteredLessonsEvent {}

class AddFilteredLesson extends FilteredLessonsEvent {
}

class UpdateFilteredLesson extends FilteredLessonsEvent{
 final Lesson updatedLesson;

  const UpdateFilteredLesson(this.updatedLesson);

  @override
  String toString() => 'UpdateFilteredLesson { updatedLesson: $updatedLesson }';
}