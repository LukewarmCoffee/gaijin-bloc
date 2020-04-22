import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../repository/kados/kado_entity.dart';

abstract class Kado extends Equatable {
  String get id; //not sure if ok
  KadoEntity toEntity();

  Kado();

  static Kado fromEntity(KadoEntity entity) {
    if (entity is TitleKadoEntity)
      return TitleKado.fromEntity(entity);
    else if (entity is VocabKadoEntity)
      return VocabKado.fromEntity(entity);
    else
      return Kado.fromEntity(entity); //shouldnt happen
  }
}

class TitleKado extends Kado {
  final String id;
  final String title;
  final String subtitle;

  TitleKado({
    @required this.title,
    String subtitle,
    String id,
  })  : this.subtitle = subtitle ?? '',
        this.id = id ?? Uuid().v4();

  @override
  List<Object> get props => [title, subtitle, id];

  static TitleKado fromEntity(TitleKadoEntity entity) {
    return TitleKado(
      title: entity.title,
      subtitle: entity.subtitle,
      id: entity.id ?? Uuid().v4(),
    );
  }

  @override
  KadoEntity toEntity() {
    return TitleKadoEntity(title, subtitle, id);
  }
}

//Special card; adds this card to deck upon finishing a lesson
class VocabKado extends Kado {
  //the word to be learned
  final String wordId;
  final bool learned;
  final String id;

  VocabKado({
    @required this.wordId,
    bool learned,
    String id,
  }) : this.learned = learned ?? false,
  this.id = id ?? Uuid().v4();

  @override
  List<Object> get props => [wordId, learned, id];

  static VocabKado fromEntity(VocabKadoEntity entity) {
    return VocabKado(
      wordId: entity.wordId,
      learned: entity.learned,
      id: entity.id ?? Uuid().v4(),
    );
  }

  @override
  KadoEntity toEntity() {
    return VocabKadoEntity(wordId, learned, id);
  }
}


//Special card; user decides whether they understand the card or not
//displays a word, in japanese, user asked for word in english
/*class ReviewKado extends Kado {
  //the word to be learned
  final String wordId;
  final String id;

  ReviewKado({
    @required this.wordId,
    String id,
  }) : this.id = id ?? Uuid().v4();

  @override
  List<Object> get props => [wordId, id];

  static VocabKado fromEntity(VocabKadoEntity entity) {
    return VocabKado(
      wordId: entity.wordId,
      id: entity.id ?? Uuid().v4(),
    );
  }

  @override
  KadoEntity toEntity() {
    return VocabKadoEntity(wordId, id);
  }
}*/

/*@HiveType(typeId: 51)
class BodyCard extends ContentCard {
  @override
  @HiveField(0)
  final bool hidden;
  @HiveField(1)
  final String body;

  BodyCard(
    this.hidden, {
    @required this.body,
  });
}*/


/*
//user decides if they understand the translation in english or not,
@HiveType(typeId: 54)
class SentenceReviewCard extends ContentCard {
  @override
  @HiveField(0)
  final bool hidden;
  //ids of all the words in the sentence
  @HiveField(1)
  final HiveList<Word> words;
  //an optional natural translation for the sentence
  @HiveField(2)
  final String translation;

  SentenceReviewCard(
    this.hidden, {
    @required this.words,
    this.translation,
  });
}*/
