abstract class KadoEntity {
  Map<String, Object> toJson();

  static KadoEntity fromJson(Map<String, Object> json) {
    if (json['type'] == 'titleKado')
      return TitleKadoEntity.fromJson(json);
    else if (json['type'] == 'vocabKado')
      return VocabKadoEntity.fromJson(json);
    else if (json['type'] == 'sentenceKado')
      return SentenceKadoEntity.fromJson(json);
    else
      return KadoEntity.fromJson(json); //shouldnt happen
  }
}

class TitleKadoEntity extends KadoEntity {
  final String title;
  final String subtitle;
  final String id;

  TitleKadoEntity(this.title, this.subtitle, this.id);

  @override
  int get hashCode => title.hashCode ^ subtitle.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TitleKadoEntity &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          subtitle == other.subtitle &&
          id == other.id;

  @override
  Map<String, Object> toJson() {
    return {
      'type': 'titleKado',
      'title': title,
      'subtitle': subtitle,
      'id': id
    };
  }

  @override
  String toString() {
    return 'TitleKadoEntity { title: $title, subtitle: $subtitle, id: $id }';
  }

  static TitleKadoEntity fromJson(Map<String, Object> json) {
    return TitleKadoEntity(
      json['title'] as String,
      json['subtitle'] as String,
      json['id'] as String,
    );
  }
}

class VocabKadoEntity extends KadoEntity {
  final String wordId;
  final bool learned;
  final String id;

  VocabKadoEntity(this.wordId, this.learned, this.id);

  @override
  int get hashCode => wordId.hashCode ^ learned.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabKadoEntity &&
          runtimeType == other.runtimeType &&
          wordId == other.wordId &&
          learned == other.learned &&
          id == other.id;

  @override
  Map<String, Object> toJson() {
    return {'type': 'vocabKado', 'wordId': wordId, 'learned': learned, 'id': id};
  }

  @override
  String toString() {
    return 'VocabKadoEntity { wordId: $wordId, learned: $learned, id: $id }';
  }

  static VocabKadoEntity fromJson(Map<String, Object> json) {
    return VocabKadoEntity(
      json['wordId'] as String,
      json['learned'] as bool,
      json['id'] as String,
    );
  }
}

class SentenceKadoEntity extends KadoEntity {
  final List<String> wordIds;
  final String translation;
  final bool learned;
  final String id;

  SentenceKadoEntity(this.wordIds, this.translation, this.learned, this.id);

  @override
  int get hashCode => wordIds.hashCode ^ translation.hashCode ^ learned.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SentenceKadoEntity &&
          runtimeType == other.runtimeType &&
          wordIds == other.wordIds &&
          translation == other.translation &&
          learned == other.learned &&
          id == other.id;

  @override
  Map<String, Object> toJson() {
    return {'type': 'sentenceKado', 'wordIds': wordIds, 'translation': translation, 'learned': learned, 'id': id};
  }

  @override
  String toString() {
    return 'SentenceKadoEntity { wordIds: $wordIds, translation: $translation, learned: $learned, id: $id }';
  }

  static SentenceKadoEntity fromJson(Map<String, Object> json) {
    return SentenceKadoEntity(
      json['wordIds'] as List<String>,
      json['translation'] as String,
      json['learned'] as bool,
      json['id'] as String,
    );
  }
}
