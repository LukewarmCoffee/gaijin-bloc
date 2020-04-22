
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/words/words_repository.dart';
import 'words_event.dart';
import 'words_state.dart';
import '../../models/word.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  final WordsRepository wordsRepository;

  WordsBloc({@required this.wordsRepository});

  @override
  WordsState get initialState => WordsLoading();

  @override
  Stream<WordsState> mapEventToState(WordsEvent event) async* {
    if (event is LoadWords) {
      yield* _mapLoadWordsToState();
    } else if (event is AddWord) {
      yield* _mapAddWordToState(event);
    } else if (event is UpdateWord) {
      yield* _mapUpdateWordToState(event);
    } else if (event is DeleteWord) {
      yield* _mapDeleteWordToState(event);
    }
  }

  Stream<WordsState> _mapLoadWordsToState() async* {
    try {
      final words = await this.wordsRepository.loadWords();
      yield WordsLoaded(
        words.map(Word.fromEntity).toList(),
      );
    } catch (_) {
      yield WordsNotLoaded();
    }
  }

  Stream<WordsState> _mapAddWordToState(AddWord event) async* {
    if (state is WordsLoaded) {
      final List<Word> updatedWords = List.from((state as WordsLoaded).words)
        ..add(event.word);
      yield WordsLoaded(updatedWords);
      _saveWords(updatedWords);
    }
  }

  Stream<WordsState> _mapUpdateWordToState(UpdateWord event) async* {
    if (state is WordsLoaded) {
      final List<Word> updatedWords = (state as WordsLoaded).words.map((word) {
        return word.id == event.updatedWord.id ? event.updatedWord : word;
      }).toList();
      yield WordsLoaded(updatedWords);
      _saveWords(updatedWords);
    }
  }

  Stream<WordsState> _mapDeleteWordToState(DeleteWord event) async* {
    if (state is WordsLoaded) {
      final updatedWords = (state as WordsLoaded)
          .words
          .where((word) => word.id != event.word.id)
          .toList();
      yield WordsLoaded(updatedWords);
      _saveWords(updatedWords);
    }
  }

  Future _saveWords(List<Word> words) {
    return wordsRepository.saveWords(
      words.map((word) => word.toEntity()).toList(),
    );
  }
}
