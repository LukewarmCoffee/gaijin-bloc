import 'dart:async';

import 'lesson_entity.dart';
import 'lessons_repository.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Todos to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class LessonsWebClient implements LessonsRepository {
  final Duration delay;

  const LessonsWebClient([this.delay = const Duration(milliseconds: 1000)]);

  /// Mock that "fetches" some Todos from a "web service" after a short delay
  @override
  Future<List<LessonEntity>> loadLessons() async {
    return Future.delayed(
        delay,
        () => [
              LessonEntity(
                'Lesson 1',
                ["1", "2"],
                0,
                true,
                '1',
              ),
              LessonEntity(
                'Lesson 2',
                ['3', '4', '5'],
                1,
                false,
                '2',
              ),
              LessonEntity(
                'Lesson 3',
                ['6', '7', '8', '9'],
                0,
                false,
                '3',
              ),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  @override
  Future<bool> saveLessons(List<LessonEntity> lessons) async {
    return Future.value(true);
  }
}
