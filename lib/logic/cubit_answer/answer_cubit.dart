import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_firebase_login/data/models/question.dart';

import '../cubit_var/exam_var_cubit.dart';

part 'answer_state.dart';

class AnswerCubit extends Cubit<AnswerState> {
  final ExamScoreCubit scoreCubit;
  final List<String> userAnswersList;
  AnswerCubit({@required this.scoreCubit, this.userAnswersList})
      : super(AnswerInitial());

  void pickAnswer(String answer) {
    emit(AnswerPicked(answer: answer));
  }

  //TODO przyznawanie pkt na koniec testu
  void takeAnswer(String questionAnswer, int type, int questionIndex) {
    if (state is AnswerPicked) {
      userAnswersList[questionIndex] = (state as AnswerPicked).answer;
      // scoreCubit.checkAnswer(
      //     (state as AnswerPicked).answer, questionAnswer, type);
    }
    emit(AnswerInitial());
  }

  void takeAnswersCardsType(String questionAnswer, int type, int questionIndex,
      String yellowCards, String redCards) {
    if (state is AnswerPicked) {
      String userAnswer =
          (state as AnswerPicked).answer + yellowCards + redCards;
      userAnswersList[questionIndex] = userAnswer;
      // scoreCubit.checkAnswer(userAnswer, questionAnswer, type);
    }
    emit(AnswerInitial());
  }

  void checkUserAnswers(List<Question> listOfQuestions) {
    for (int i = 0; i < userAnswersList.length; i++) {
      scoreCubit.checkAnswer(userAnswersList[i], listOfQuestions[i].answer,
          listOfQuestions[i].type);
    }
  }
}
