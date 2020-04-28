import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../bloc.dart';


class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final LessonsBloc lessonsBloc;
  StreamSubscription lessonsSubscription;

  ProgressBloc({@required this.lessonsBloc}) {
    lessonsSubscription = lessonsBloc.listen((state) {
      if (state is LessonsLoaded) {
        add(UpdateProgress(state.lessons));
      }
    });
  }

  @override
  ProgressState get initialState => ProgressLoading();

  @override
  Stream<ProgressState> mapEventToState(ProgressEvent event) async* {
    if (event is UpdateProgress) {
      bool lessonNeeded; 
      //if the last lesson in lessons has been completed, a new lesson is needed
      if (event.lessons[event.lessons.length -1].progress == event.lessons[event.lessons.length - 1].kadoIds.length -1)
        lessonNeeded = true;
      else
        lessonNeeded = false;

      yield ProgressLoaded(lessonNeeded);
    }
  }

  @override
  Future<void> close() {
    lessonsSubscription.cancel();
    return super.close();
  }
}