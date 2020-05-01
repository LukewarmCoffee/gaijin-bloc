import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';

import 'lesson_entity.dart';
import 'lessons_repository.dart';
import 'lessons_web_client.dart';


/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class LessonsConcreteRepository implements LessonsRepository {
  final LessonsRepository localStorage;
  final LessonsRepository webClient;

  const LessonsConcreteRepository({
    @required this.localStorage,
    this.webClient = const LessonsWebClient(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<LessonEntity>> loadLessons() async {
    try {
      return await localStorage.loadLessons();
    } catch (e) {
      final lessons = await webClient.loadLessons();
      print('couldnt load local');
      await localStorage.saveLessons(lessons);

      return lessons;
    }
  }

  // Persists notes to local disk and the web
  @override
  Future saveLessons(List<LessonEntity> lessons) {
    return Future.wait<dynamic>([
      localStorage.saveLessons(lessons),
      webClient.saveLessons(lessons),
    ]);
  }
}

class FilteredLessonsConcreteRepository implements LessonsRepository {
  final LessonsRepository localStorage;
  final LessonsRepository webClient;

  const FilteredLessonsConcreteRepository({
    @required this.localStorage,
    this.webClient = const FilteredLessonsWebClient(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<LessonEntity>> loadLessons() async {
    try {
      return await localStorage.loadLessons();
    } catch (e) {
      final lessons = await webClient.loadLessons();
      print('couldnt load local');
      await localStorage.saveLessons(lessons);

      return lessons;
    }
  }

  // Persists notes to local disk and the web
  @override
  Future saveLessons(List<LessonEntity> lessons) {
    return Future.wait<dynamic>([
      localStorage.saveLessons(lessons),
      webClient.saveLessons(lessons),
    ]);
  }
}