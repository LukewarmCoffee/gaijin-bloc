import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../repository/kados/kado_entity.dart';

abstract class Kado extends Equatable {
  String get id; 
  KadoEntity toEntity();

  Kado();

  static Kado fromEntity(KadoEntity entity) {
    if (entity is TitleKadoEntity)
      return TitleKado.fromEntity(entity);
    else if (entity is VocabKadoEntity)
      return VocabKado.fromEntity(entity);
    else if (entity is SentenceKadoEntity)
      return SentenceKado.fromEntity(entity);
    else
      return Kado.fromEntity(entity); //shouldnt happen
  }
}

class TitleKado extends Kado {
  final String id;
  final String title;
  final String subtitle;

  TitleKado({
    String title,
    String subtitle,
    String id,
  })  : this.title = title ?? '',
   this.subtitle = subtitle ?? '',
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
  //if true, displays a review instead of a new vocab
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



class SentenceKado extends Kado {
  final List<String> wordIds;
  //an optional natural translation for the sentence
  final String translation;
  final bool learned;
  final String id;

  SentenceKado({
    @required this.wordIds,
    String translation,
    bool learned,
    String id,
  }) : this.translation = translation ?? '', 
  this.learned = learned ?? false,
  this.id = id ?? Uuid().v4();

 @override
  List<Object> get props => [wordIds, translation, learned, id];

  static SentenceKado fromEntity(SentenceKadoEntity entity) {
    return SentenceKado(
      wordIds: entity.wordIds,
      translation: entity.translation,
      learned: entity.learned,
      id: entity.id ?? Uuid().v4(),
    );
  }

  @override
  KadoEntity toEntity() {
    return SentenceKadoEntity(wordIds, translation, learned, id);
  }

}
