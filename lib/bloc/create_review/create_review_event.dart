import 'package:equatable/equatable.dart';

import '../../models/models.dart';

abstract class CreateReviewEvent extends Equatable {
  const CreateReviewEvent();
}

class UpdateKados extends CreateReviewEvent {
  final List<Kado> kados;

  const UpdateKados(this.kados);

  @override
  List<Object> get props => [kados];

  @override
  String toString() => 'UpdateKados { kados: $kados }';
}

class UpdateWords extends CreateReviewEvent {
  final List<Word> words;

  const UpdateWords(this.words);

  @override
  List<Object> get props => [words];

  @override
  String toString() => 'UpdateWords { words: $words }';
}