
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/lessons/lessons_repository.dart';
import '../../models/lesson.dart';
import 'lessons_event.dart';
import 'lessons_state.dart';

class LessonsBloc extends Bloc<LessonsEvent, LessonsState> {
  final LessonsRepository lessonsRepository;

  LessonsBloc({@required this.lessonsRepository});

  @override
  LessonsState get initialState => LessonsLoading();

  @override
  Stream<LessonsState> mapEventToState(LessonsEvent event) async* {
    if (event is LoadLessons) {
      yield* _mapLoadLessonsToState();
    } else if (event is AddLesson) {
      yield* _mapAddLessonToState(event);
    } else if (event is UpdateLesson) {
      yield* _mapUpdateLessonToState(event);
    } else if (event is DeleteLesson) {
      yield* _mapDeleteLessonToState(event);
    }
  }

  Stream<LessonsState> _mapLoadLessonsToState() async* {
    try {
      final lessons = await this.lessonsRepository.loadLessons();
      yield LessonsLoaded(
        lessons.map(Lesson.fromEntity).toList(),
      );
    } catch (_) {
      yield LessonsNotLoaded();
    }
  }

  Stream<LessonsState> _mapAddLessonToState(AddLesson event) async* {
    if (state is LessonsLoaded) {
      final List<Lesson> updatedLessons = List.from((state as LessonsLoaded).lessons)
        ..add(event.lesson);
      yield LessonsLoaded(updatedLessons);
      _saveLessons(updatedLessons);
    }
  }

  Stream<LessonsState> _mapUpdateLessonToState(UpdateLesson event) async* {
    if (state is LessonsLoaded) {
      final List<Lesson> updatedLessons = (state as LessonsLoaded).lessons.map((lesson) {
        return lesson.id == event.updatedLesson.id ? event.updatedLesson : lesson;
      }).toList();
      yield LessonsLoaded(updatedLessons);
      _saveLessons(updatedLessons);
    }
  }

  Stream<LessonsState> _mapDeleteLessonToState(DeleteLesson event) async* {
    if (state is LessonsLoaded) {
      final updatedLessons = (state as LessonsLoaded)
          .lessons
          .where((lesson) => lesson.id != event.lesson.id)
          .toList();
      yield LessonsLoaded(updatedLessons);
      _saveLessons(updatedLessons);
    }
  }

  Future _saveLessons(List<Lesson> lessons) {
    return lessonsRepository.saveLessons(
      lessons.map((lesson) => lesson.toEntity()).toList(),
    );
  }
}
