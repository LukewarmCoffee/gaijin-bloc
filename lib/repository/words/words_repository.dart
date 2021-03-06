import 'dart:async';
import 'dart:core';

import 'word_entity.dart';

/// A class that Loads and Persists todos. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as notes_repository_simple or notes_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class WordsRepository {
  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  Future<List<WordEntity>> loadWords();

  // Persists todos to local disk and the web
  Future saveWords(List<WordEntity> words);
}