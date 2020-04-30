import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../bloc.dart';

class FilteredLessonsBloc
    extends Bloc<FilteredLessonsEvent, FilteredLessonsState> {
  final LessonsBloc lessonsBloc;
  StreamSubscription lessonsSubscription;

  FilteredLessonsBloc({@required this.lessonsBloc}) {
    lessonsSubscription = lessonsBloc.listen((state) {
      if (state is LessonsLoaded) {
        add(UpdateLessons((lessonsBloc.state as LessonsLoaded).lessons));
      }
    });
  }

  @override
  FilteredLessonsState get initialState {
    return lessonsBloc.state is LessonsLoaded
        ? FilteredLessonsLoaded(
            (lessonsBloc.state as LessonsLoaded).lessons,
          )
        : FilteredLessonsLoading();
  }

  @override
  Stream<FilteredLessonsState> mapEventToState(
      FilteredLessonsEvent event) async* {
    if (event is UpdateLessons) {
      yield* _mapUpdateLessonsToState(event);
    }
  }
  //TODO remove this
  Stream<FilteredLessonsState> _mapUpdateLessonsToState(
    UpdateLessons event,
  ) async* {
    final lessons = event.lessons.where((lesson) => lesson.visible).toList();

    yield FilteredLessonsLoaded(lessons);
  }
  //add lesson
  //compare current filtered lessons and lessons, adding any new lessons

  //load lessons
  //initial one time load up

  @override
  Future<void> close() {
    lessonsSubscription.cancel();
    return super.close();
  }
}
