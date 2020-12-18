part of 'exam_bloc.dart';

abstract class ExamEvent extends Equatable {
  const ExamEvent();

  @override
  List<Object> get props => [];
}

class ExamFetched extends ExamEvent {}

class ExamFinishedEvent extends ExamEvent {}
