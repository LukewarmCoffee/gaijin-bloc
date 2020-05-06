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
    } else if (event is UpdateFilteredLesson) {
      yield* _mapUpdateLessonToState(event);
    }
  }

  Stream<FilteredLessonsState> _mapUpdateLessonToState(
      UpdateFilteredLesson event) async* {
    if (state is FilteredLessonsLoaded) {
      final List<Lesson> updatedLessons =
          (state as LessonsLoaded).lessons.map((lesson) {
        return lesson.id == event.updatedLesson.id
            ? event.updatedLesson
            : lesson;
      }).toList();
      //progress of last lesson == length of cards
      if (updatedLessons[updatedLessons.length - 1].progress ==
          updatedLessons[updatedLessons.length - 1].kadoIds.length - 1) {
        int lessonIndex = (state as FilteredLessonsLoaded).lessonsIndex;
        final List<Lesson> lessons =
            (lessonsBloc.state as LessonsLoaded).lessons;

        if (lessonIndex < lessons.length)
          updatedLessons.add(lessons[lessonIndex]);

        yield FilteredLessonsLoaded(updatedLessons, lessonIndex + 1);
      }
      else
        yield FilteredLessonsLoaded(updatedLessons, updatedLessons.length);
      _saveLessons(updatedLessons);
    }
  }

  //add lesson
  //compare current filtered lessons and lessons, adding any new lessons
  Stream<FilteredLessonsState> _mapAddLessonToState(
      AddFilteredLesson event) async* {
    List<Lesson> filteredLessons =
        List.from((state as FilteredLessonsLoaded).filteredLessons);
    int lessonIndex = (state as FilteredLessonsLoaded).lessonsIndex;
    final List<Lesson> lessons = (lessonsBloc.state as LessonsLoaded).lessons;

    if (lessonIndex < lessons.length) filteredLessons.add(lessons[lessonIndex]);

    yield FilteredLessonsLoaded(filteredLessons, lessonIndex + 1);
  }

  //load lessons
  //initial one time load up
  Stream<FilteredLessonsState> _mapLoadLessonsToState() async* {
    try {
      final lessons = await this.lessonsRepository.loadLessons();
      yield FilteredLessonsLoaded(lessons.map(Lesson.fromEntity).toList(),
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

  Future _saveLessons(List<Lesson> lessons) {
    return lessonsRepository.saveLessons(
      lessons.map((lesson) => lesson.toEntity()).toList(),
    );
  }
}
