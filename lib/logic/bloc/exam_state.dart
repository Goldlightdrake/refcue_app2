part of 'exam_bloc.dart';

abstract class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object> get props => [];
}

class ExamLoading extends ExamState {}

class ExamReady extends ExamState {
  final List<Question> questionList;
  ExamReady({
    this.questionList,
  });

  @override
  List<Object> get props => [questionList];

  String toString() => "{ExamReady: QuestionList: $questionList}";
}

class ExamError extends ExamState {}
