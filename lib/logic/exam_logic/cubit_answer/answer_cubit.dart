import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:refcue_app/data/models/question.dart';

import '../cubit_var/exam_var_cubit.dart';

part 'answer_state.dart';

class AnswerCubit extends Cubit<AnswerState> {
  final ExamScoreCubit scoreCubit;
  final List<String> userAnswersList;
  AnswerCubit({
    @required this.scoreCubit,
    this.userAnswersList,
  }) : super(AnswerInitial());

  List<int> pointsForQuestions = [];

  void pickAnswer(String answer) {
    emit(AnswerPicked(answer: answer));
  }

  void takeAnswer(String questionAnswer, int type, int questionIndex) {
    if (state is AnswerPicked) {
      userAnswersList[questionIndex] = (state as AnswerPicked).answer;
    }
    emit(AnswerInitial());
  }

  void takeAnswersCardsType(String questionAnswer, int type, int questionIndex,
      String yellowCards, String redCards) {
    if (state is AnswerPicked) {
      String userAnswer =
          (state as AnswerPicked).answer + yellowCards + redCards;
      userAnswersList[questionIndex] = userAnswer;
      emit(AnswerInitial());
    } else {
      String userAnswer = '-' + yellowCards + redCards;
      userAnswersList[questionIndex] = userAnswer;
    }
    emit(AnswerInitial());
  }

  void checkUserAnswers(List<Question> listOfQuestions) {
    for (int i = 0; i < userAnswersList.length; i++) {
      pointsForQuestions.add(scoreCubit.checkAnswer(userAnswersList[i],
          listOfQuestions[i].answer, listOfQuestions[i].type));
    }
  }
}
