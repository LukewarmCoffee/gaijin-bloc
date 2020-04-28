import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';
import '../bloc.dart';

class CreateReviewBloc extends Bloc<CreateReviewEvent, CreateReviewState> {
  final KadosBloc kadosBloc;
  StreamSubscription kadosSubscription;
  final WordsBloc wordsBloc;
  StreamSubscription wordsSubscription;

  CreateReviewBloc({@required this.kadosBloc, @required this.wordsBloc}) {
    kadosSubscription = kadosBloc.listen((state) {
      if (state is KadosLoaded) {
        add(UpdateKados((kadosBloc.state as KadosLoaded).kados));
      }
    });

    wordsSubscription = wordsBloc.listen((state) {
      if (state is WordsLoaded) {
        add(UpdateWords((wordsBloc.state as WordsLoaded).words));
      }
    });
  }

  @override
  CreateReviewState get initialState {
    return kadosBloc.state is KadosLoaded && wordsBloc.state is WordsLoaded
        ? CreateReviewLoaded(
            //exposes the entire list of kados, oops
           ['1'],
          )
        : CreateReviewLoading();
  }

  @override
  Stream<CreateReviewState> mapEventToState(CreateReviewEvent event) async* {
    if (event is UpdateWords) {
      yield* _mapUpdateWordsToState(event);
    } else if (event is UpdateKados) {
      yield* _mapUpdateKadosToState(event);
    }
  }

  Stream<CreateReviewState> _mapUpdateWordsToState(UpdateWords event) async* {
    if (wordsBloc.state is WordsLoaded) {
      yield CreateReviewLoaded(
        _mapWordsAndKadosToLesson(
          (kadosBloc.state as KadosLoaded).kados,
          event.words,
        ),
      );
    }
  }

  Stream<CreateReviewState> _mapUpdateKadosToState(
    UpdateKados event,
  ) async* {
    if (wordsBloc.state is KadosLoaded) {
      yield CreateReviewLoaded(
        _mapWordsAndKadosToLesson(
          event.kados,
          (wordsBloc.state as WordsLoaded).words,
        ),
      );
    }
  }

  List<String> _mapWordsAndKadosToLesson(
      List<Kado> kados, List<Word> words) {
    return ['1', '2', '3'];
  }

  @override
  Future<void> close() {
    kadosSubscription.cancel();
    wordsSubscription.cancel();
    return super.close();
  }
}
