
import 'package:equatable/equatable.dart';

import '../../models/word.dart';

abstract class WordsState extends Equatable {
  const WordsState();

  @override
  List<Object> get props => [];
}

class WordsLoading extends WordsState {}

class WordsLoaded extends WordsState {
  final List<Word> words;
  
  const WordsLoaded([this.words = const[]]);

  @override
  List<Object> get props => [words];

  @override 
  String toString() => 'WordsLoaded { words: $words }';

}

class WordsNotLoaded extends WordsState {}