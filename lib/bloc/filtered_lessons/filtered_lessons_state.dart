
import 'package:equatable/equatable.dart';

import '../../models/lesson.dart';

abstract class FilteredLessonsState extends Equatable {
  const FilteredLessonsState();

  @override
  List<Object> get props => [];
}

class FilteredLessonsLoading extends FilteredLessonsState {}

class FilteredLessonsLoaded extends FilteredLessonsState {
  final List<Lesson> filteredLessons;
  
  const FilteredLessonsLoaded([this.filteredLessons = const[]]);

  @override
  List<Object> get props => [filteredLessons];

  @override 
  String toString() => 'FilteredLessonsLoaded { filteredlessons: $filteredLessons }';

}

class FilteredLessonsNotLoaded extends FilteredLessonsState {}