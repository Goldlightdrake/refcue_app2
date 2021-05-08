import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refcue_app/logic/exam_logic/exam_logic.dart';

void parsingUserAnswer(BuildContext context, String? userAnswer) {
  if (userAnswer != "-") {
    if (userAnswer![0] == "t") {
      userAnswer = "tak";
      context.read<AnswerCubit>().pickAnswer(userAnswer);
    } else if (userAnswer[0] == "n") {
      userAnswer = "nie";
      context.read<AnswerCubit>().pickAnswer(userAnswer);
    } else {
      if (userAnswer.length > 3) {
        context.read<AnswerCubit>().pickAnswer(userAnswer[0] + userAnswer[1]);
        if (userAnswer[2] != '0') {
          context.read<CardsCubit>().setYellowCards(int.parse(userAnswer[2]));
        }
        if (userAnswer[3] != '0') {
          context.read<CardsCubit>().setRedCards(int.parse(userAnswer[3]));
        }
      } else {
        context.read<AnswerCubit>().pickAnswer(userAnswer[0]);
        if (userAnswer[1] != '0') {
          context.read<CardsCubit>().setYellowCards(int.parse(userAnswer[1]));
        }
        if (userAnswer[2] != '0') {
          context.read<CardsCubit>().setRedCards(int.parse(userAnswer[2]));
        }
      }
    }
  }
}
