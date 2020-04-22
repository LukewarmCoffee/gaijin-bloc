import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../repository/words/word_entity.dart';

//can contain multiple kanji
//word != lexeme
//as in, each word only represents a single definition and not all of its constiuents
class Word extends Equatable {
  //most common reading for this word; kanji included
  final String japanese;
  //no kanji
  final String kana;
  //the smallest possible translation for this word
  //do not include multiple definitions here
  final String english;
  //if this kanji has multiple uses, only explain the one you are using in the english category
  final String definition;
  //how well the user knows this word, starts at 0
  final double confidence;
  //if the user has learned this word
  final bool learned;
  final String id;

  Word({
    @required this.japanese,
    @required this.kana,
    @required this.english,
    @required this.definition,
    double confidence = 0.0,
    bool learned = false,
    String id,
  })  : this.confidence = confidence ?? 0.0,
        this.learned = learned ?? false,
        this.id = id ?? Uuid().v4();

  @override
  List<Object> get props =>
      [japanese, kana, english, definition, confidence, learned, id];

  Word copyWith({String japanese, String kana, String english, String definition, double confidence, bool learned, String id}) {
    return Word(
      japanese: japanese ?? this.japanese,
      kana: kana ?? this.kana,
      english: english ?? this.english,
      definition: definition ?? this.definition,
      confidence: confidence ?? this.confidence,
      learned: learned ?? this.learned,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'Word {japanese: $japanese, kana: $kana, english: $english, definition: $definition, confidence: $confidence, learned: $learned, id: $id }';
  }

  WordEntity toEntity() {
    return WordEntity(japanese, kana, english, definition, confidence, learned, id);
  }

  static Word fromEntity(WordEntity entity) {
    return Word(
      japanese: entity.japanese,
      kana: entity.kana,
      english: entity.english,
      definition: entity.definition,
      confidence: entity.confidence ?? 0.0,
      learned: entity.learned ?? false,
      id: entity.id ?? Uuid().v4(),
    );
  }
}
