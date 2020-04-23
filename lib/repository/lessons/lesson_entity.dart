class LessonEntity {
  final String title;
  final List<String> cardIds;
  final int progress;
  final String id;

  LessonEntity(this.title, this.cardIds, this.progress, this.id);

  @override
  int get hashCode =>
      title.hashCode ^
      cardIds.hashCode ^
      progress.hashCode ^
      id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonEntity &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          cardIds == other.cardIds &&
          progress == other.progress &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'title': title,
      'cardIds': cardIds,
      'progrss': progress,
      'id': id
    };
  }

  @override
  String toString() {
    return 'LessonEntity { title: $title, cardIds: $cardIds, progress: $progress, id: $id }';
  }

  static LessonEntity fromJson(Map<String, Object> json) {
    return LessonEntity(
      json['title'] as String,
      json['cardIds'] as List<String>,
      json['progress'] as int,
      json['id'] as String,
    );
  }
}
