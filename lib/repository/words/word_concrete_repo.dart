import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';

import 'word_entity.dart';
import 'word_web_client.dart';
import 'words_repository.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class WordConcreteRepository implements WordsRepository {
  final WordsRepository localStorage;
  final WordsRepository webClient;

  const WordConcreteRepository({
    @required this.localStorage,
    this.webClient = const WordWebClient(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<WordEntity>> loadWords() async {
    try {
      return await localStorage.loadWords();
    } catch (e) {
      final words = await webClient.loadWords();

      await localStorage.saveWords(words);

      return words;
    }
  }

  // Persists notes to local disk and the web
  @override
  Future saveWords(List<WordEntity> words) {
    return Future.wait<dynamic>([
      localStorage.saveWords(words),
      webClient.saveWords(words),
    ]);
  }
}