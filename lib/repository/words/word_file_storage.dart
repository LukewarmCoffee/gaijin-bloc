import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'word_entity.dart';
import 'words_repository.dart';

class WordFileStorage implements WordsRepository {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const WordFileStorage(
    this.tag,
    this.getDirectory,
  );

  @override
  Future<List<WordEntity>> loadWords() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final words = (json['words'])
        .map<WordEntity>((word) => WordEntity.fromJson(word))
        .toList();

    return words;
  }

  @override
  Future<File> saveWords(List<WordEntity> words) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'words': words.map((word) => word.toJson()).toList(),
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