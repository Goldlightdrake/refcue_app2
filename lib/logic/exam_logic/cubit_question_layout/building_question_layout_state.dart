part of 'building_question_layout_cubit.dart';

abstract class BuildingQuestionLayoutState extends Equatable {
  const BuildingQuestionLayoutState();

  @override
  List<Object?> get props => [];
}

class BuildingQuestionLayoutLoading extends BuildingQuestionLayoutState {}

class QuestionLayoutBuilt extends BuildingQuestionLayoutState {
  final Question? question;
  QuestionLayoutBuilt({
    this.question,
  });

  @override
  List<Object?> get props => [question];
}

class QuestionLayoutError extends BuildingQuestionLayoutState {}
