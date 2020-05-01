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

class LoadFilteredLessons extends FilteredLessonsEvent {}

class AddFilteredLesson extends FilteredLessonsEvent {
}
