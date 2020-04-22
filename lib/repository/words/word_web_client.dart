import 'dart:async';

import 'word_entity.dart';
import 'words_repository.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Todos to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WordWebClient implements WordsRepository {
  final Duration delay;

  const WordWebClient([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some Todos from a "web service" after a short delay
  @override
  Future<List<WordEntity>> loadWords() async {
    return Future.delayed(
        delay,
        () => [
              WordEntity(
                'Japanese',
                'Kana',
                'English',
                'definition',
                0.0,
                true,
                '1',
              ),
              WordEntity(
                'Japanese 2',
                'Kana 2',
                'English',
                'definition',
                0.0,
                true,
                '2',
              ),
              WordEntity(
                'Japanese 3',
                'Kana 3',
                'English',
                'definition',
                0.0,
                true,
                '3',
              ),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  @override
  Future<bool> saveWords(List<WordEntity> words) async {
    return Future.value(true);
  }
}
