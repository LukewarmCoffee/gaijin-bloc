class LessonEntity {
  final String title;
  final List<String> cardIds;
  final String id;

  LessonEntity(this.title, this.cardIds, this.id);

  @override
  int get hashCode =>
      title.hashCode ^
      cardIds.hashCode ^
      id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonEntity &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          cardIds == other.cardIds &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'title': title,
      'cardIds': cardIds,
      'id': id
    };
  }

  @override
  String toString() {
    return 'LessonEntity { title: $title, cardIds: $cardIds, id: $id }';
  }

  static LessonEntity fromJson(Map<String, Object> json) {
    return LessonEntity(
      json['title'] as String,
      json['cardIds'] as List<String>,
      json['id'] as String,
    );
  }
}
