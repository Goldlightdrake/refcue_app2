import 'package:bloc/bloc.dart';

class ExamScoreCubit extends Cubit<double> {
  ExamScoreCubit() : super(0);

  int checkAnswer(String userAnswer, String questionAnswer, int type) {
    if (type == 0) {
      if (userAnswer[0] == questionAnswer[0]) {
        if (userAnswer[2] == questionAnswer[2]) {
          if (userAnswer[1] == questionAnswer[1]) {
            emit(state + 1);
            return 2;
          } else if (int.parse(userAnswer[1]) + 1 ==
                  int.parse(questionAnswer[1]) ||
              int.parse(userAnswer[1]) - 1 == int.parse(questionAnswer[1])) {
            emit(state + 0.5);
            return 1;
          }
        }
      }
    } else if (type == 1) {
      //TODO typ 1 ocena
    } else {
      if (userAnswer == questionAnswer) {
        emit(state + 1);
        return 2;
      }
    }
    return 0;
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
