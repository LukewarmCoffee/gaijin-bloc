class WordEntity {
  final String japanese;
  final String kana;
  final String english;
  final String definition;
  final double confidence;
  final bool learned;
  final String id;

  WordEntity(this.japanese, this.kana, this.english,
      this.definition, this.confidence, this.learned, this.id);

  @override
  int get hashCode =>
      japanese.hashCode ^
      kana.hashCode ^
      english.hashCode ^
      definition.hashCode ^
      confidence.hashCode ^
      learned.hashCode ^
      id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordEntity &&
          runtimeType == other.runtimeType &&
          japanese == other.japanese &&
          kana == other.kana &&
          english == other.english &&
          definition == other.definition &&
          confidence == other.confidence &&
          learned == other.learned &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'japanese': japanese,
      'kana': kana,
      'english': english,
      'definition': definition,
      'confidence': confidence,
      'learned': learned,
      'id': id
    };
  }

  @override
  String toString() {
    return 'WordEntity {japanese: $japanese, kana: $kana, english: $english, definition: $definition, confidence: $confidence, learned: $learned, id: $id}';
  }

  static WordEntity fromJson(Map<String, Object> json) {
    return WordEntity(
      json['japanese'] as String,
      json['kana'] as String,
      json['english'] as String,
      json['definition'] as String,
      json['confidence'] as double,
      json['learned'] as bool,
      json['id'] as String,
    );
  }
}
