import 'package:bloc/bloc.dart';

class ExamScoreCubit extends Cubit<double> {
  ExamScoreCubit() : super(0);

  void checkAnswer(String userAnswer, String questionAnswer, int type) {
    if (type == 0) {
      List listQuestionAnswer = questionAnswer.split(',');
      List listUserAnswer = userAnswer.split(',');
      if (listUserAnswer[0] == listQuestionAnswer[0]) {
        //TODO zrobić punktacje
      }
    } else if (type == 1) {
    } else {
      if (userAnswer == questionAnswer) {
        emit(state + 1);
      }
    }
  }
}

class ExamQuestionIndexCubit extends Cubit<int> {
  ExamQuestionIndexCubit() : super(0);

  void goToNextQuestion() {
    emit(state + 1);
  }

  void goToPrevQuestion() {
    emit(state - 1);
  }
}
