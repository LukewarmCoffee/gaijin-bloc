
import 'package:equatable/equatable.dart';

import '../../models/lesson.dart';

abstract class LessonsState extends Equatable {
  const LessonsState();

  @override
  List<Object> get props => [];
}

class LessonsLoading extends LessonsState {}

class LessonsLoaded extends LessonsState {
  final List<Lesson> lessons;
  
  const LessonsLoaded([this.lessons = const[]]);

  @override
  List<Object> get props => [lessons];

  @override 
  String toString() => 'LessonsLoaded { lessons: $lessons }';

}

class LessonsNotLoaded extends LessonsState {}