import 'dart:async';
import 'dart:core';

import 'lesson_entity.dart';

abstract class LessonsRepository {
  /// Loads lessons first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the lessons from a Web Client.
  Future<List<LessonEntity>> loadLessons();

  // Persists lessons to local disk and the web
  Future saveLessons(List<LessonEntity> lessons);
}