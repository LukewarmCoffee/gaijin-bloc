import 'package:equatable/equatable.dart';

import '../../models/word.dart';

abstract class WordsEvent extends Equatable {
  const WordsEvent();

  @override
  List<Object> get props => [];
}

class LoadWords extends WordsEvent {}

class AddWord extends WordsEvent {
  final Word word;

  const AddWord(this.word);

  @override
  List<Object> get props => [word];

  @override
  String toString() => 'AddWord { word: $word }';
}

class UpdateWord extends WordsEvent {
  final Word updatedWord;

  const UpdateWord(this.updatedWord);

  @override
  String toString() => 'UpdateWord { updatedWord: $updatedWord }';
}

class DeleteWord extends WordsEvent {
  final Word word;

  const DeleteWord(this.word);

  @override
  List<Object> get props => [word];

  @override
  String toString() => 'DeleteWord { word: $word }';
}