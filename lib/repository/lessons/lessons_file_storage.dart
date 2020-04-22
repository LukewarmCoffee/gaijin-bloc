import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'lesson_entity.dart';
import 'lessons_repository.dart';

class LessonsFileStorage implements LessonsRepository {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const LessonsFileStorage(
    this.tag,
    this.getDirectory,
  );

  @override
  Future<List<LessonEntity>> loadLessons() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final lessons = (json['lessons'])
        .map<LessonEntity>((lesson) => LessonEntity.fromJson(lesson))
        .toList();

    return lessons;
  }

  @override
  Future<File> saveLessons(List<LessonEntity> lessons) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/GaijinAppStorage__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}