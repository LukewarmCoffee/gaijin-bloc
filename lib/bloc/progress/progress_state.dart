import 'package:equatable/equatable.dart';

abstract class ProgressState extends Equatable {
  const ProgressState();

  @override
  List<Object> get props => [];
}

class ProgressLoading extends ProgressState {}

class ProgressLoaded extends ProgressState {
  final bool lessonNeeded;

  const ProgressLoaded(this.lessonNeeded);

  @override
  List<Object> get props => [lessonNeeded];

  @override
  String toString() {
    return 'ProgressLoaded { lessonNeeded: $lessonNeeded }';
  }
}