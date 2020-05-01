import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/repository.dart';
import '../bloc.dart';
import '../../models/models.dart';

class FilteredLessonsBloc
    extends Bloc<FilteredLessonsEvent, FilteredLessonsState> {
  final LessonsBloc lessonsBloc;
  StreamSubscription lessonsSubscription;
  final LessonsRepository lessonsRepository;

  FilteredLessonsBloc(
      {@required this.lessonsBloc, @required this.lessonsRepository}) {
    lessonsSubscription = lessonsBloc.listen((state) {
      /*add lesson here based on progress*/
      if (state is LessonsLoaded) {
        add(UpdateLessons((lessonsBloc.state as LessonsLoaded).lessons));
      }
    });
  }

  @override
  FilteredLessonsState get initialState => FilteredLessonsLoading();

  @override
  Stream<FilteredLessonsState> mapEventToState(
      FilteredLessonsEvent event) async* {
    if (event is LoadFilteredLessons) {
      yield* _mapLoadLessonsToState();
    } else if (event is AddFilteredLesson) {
      yield* _mapAddLessonToState(event);
    }
  }

  //TODO updateState
  //after update, if progress on last... you know what to do

  //add lesson
  //compare current filtered lessons and lessons, adding any new lessons
  Stream<FilteredLessonsState> _mapAddLessonToState(
      AddFilteredLesson event) async* {
    List<Lesson> filteredLessons =
        List.from((state as FilteredLessonsLoaded).filteredLessons);
    int lessonIndex = (state as FilteredLessonsLoaded).lessonsIndex;
    final List<Lesson> lessons = (lessonsBloc.state as LessonsLoaded).lessons;

    if (lessonIndex < lessons.length)
      filteredLessons.add(lessons[lessonIndex++]);

    yield FilteredLessonsLoaded(filteredLessons, lessonIndex);
  }

  //load lessons
  //initial one time load up
  Stream<FilteredLessonsState> _mapLoadLessonsToState() async* {
    try {
      final lessons = await this.lessonsRepository.loadLessons();
      yield FilteredLessonsLoaded(
        lessons.map(Lesson.fromEntity).toList(),
        1 //index, this will reset every time oops
      );
    } catch (_) {
      yield FilteredLessonsNotLoaded();
    }
  }

  @override
  Future<void> close() {
    lessonsSubscription.cancel();
    return super.close();
  }
}
