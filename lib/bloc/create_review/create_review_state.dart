import 'package:equatable/equatable.dart';

abstract class  CreateReviewState extends Equatable {
  const CreateReviewState();

  @override
  List<Object> get props => [];
}

class CreateReviewLoading extends CreateReviewState {}

class CreateReviewLoaded extends CreateReviewState {
  final List<String> lessonKadoIds;

  const CreateReviewLoaded(
    this.lessonKadoIds,
  );

  @override
  List<Object> get props => [lessonKadoIds];

  @override
  String toString() {
    return 'CreateReviewLoaded { lessonKados: $lessonKadoIds }';
  }
}
