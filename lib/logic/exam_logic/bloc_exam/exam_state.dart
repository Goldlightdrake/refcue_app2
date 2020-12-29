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

  String toString() => "{ ExamReady: QuestionList: $questionList }";
}

class ExamFinished extends ExamState {
  final List<String> userAnswers;
  final double userScore;
  final int examMaxScore;
  final List<Question> questionsList;
  ExamFinished({
    this.userAnswers,
    this.userScore,
    this.examMaxScore,
    this.questionsList,
  });

  @override
  List<Object> get props => [userAnswers, userScore, examMaxScore];
  String toString() =>
      "{ ExamFinished: score $userScore/$examMaxScore, Answers: $userAnswers, questionsList: $questionsList }";
}

class ExamError extends ExamState {}
