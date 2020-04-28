import 'package:equatable/equatable.dart';
import '../../models/lesson.dart';

abstract class ProgressEvent extends Equatable {
  const ProgressEvent();
}

class UpdateProgress extends ProgressEvent {
  final List<Lesson> lessons;

  const UpdateProgress(this.lessons);

  @override
  List<Object> get props => [lessons];

  @override
  String toString() => 'UpdateProgress { lessons: $lessons }';
}