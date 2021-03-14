import 'package:flutter/material.dart';
import 'package:refcue_app/data/models/question.dart';
import 'package:refcue_app/logic/exam_logic/exam_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void submitButtonAction(BuildContext context, Question? question) {
  if (context.read<ExamQuestionIndexCubit>().state ==
      context.read<ExamBloc>().maxIndex! - 1) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Theme.of(context).cardColor,
              title: Text("Chcesz zakończyć test?",
                  style: kTitleTextStyle.copyWith(
                      fontSize: kSpacingUnit.w * 2,
                      color: Theme.of(context).textTheme.bodyText1!.color)),
              elevation: 24.0,
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).textTheme.bodyText1!.color),
                    child: Text("Tak"),
                    onPressed: () {
                      if (question!.type == 0) {
                        var yellowCards = context
                            .read<CardsCubit>()
                            .state
                            .yellowCards
                            .toString();
                        var redCards = context
                            .read<CardsCubit>()
                            .state
                            .redCards
                            .toString();
                        context.read<AnswerCubit>().takeAnswersCardsType(
                            question.answer,
                            question.type,
                            context.read<ExamQuestionIndexCubit>().state,
                            yellowCards,
                            redCards);
                        context.read<CardsCubit>().clearCards();
                      } else {
                        context.read<AnswerCubit>().takeAnswer(
                            question.answer,
                            question.type,
                            context.read<ExamQuestionIndexCubit>().state);
                      }
                      context.read<TimerBloc>().add(TimerPaused());
                      context.read<AnswerCubit>().checkUserAnswers(
                          (context.read<ExamBloc>().state as ExamReady)
                              .questionList);
                      context.read<ExamQuestionIndexCubit>().goToNextQuestion();
                      Navigator.of(context, rootNavigator: true).pop();
                    }),
                TextButton(
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).textTheme.bodyText1!.color),
                  child: Text("Nie"),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                )
              ],
            ));
  } else {
    if (question!.type == 0) {
      var yellowCards = context.read<CardsCubit>().state.yellowCards.toString();
      var redCards = context.read<CardsCubit>().state.redCards.toString();
      context.read<AnswerCubit>().takeAnswersCardsType(
          question.answer,
          question.type,
          context.read<ExamQuestionIndexCubit>().state,
          yellowCards,
          redCards);
      context.read<CardsCubit>().clearCards();
    } else {
      context.read<AnswerCubit>().takeAnswer(question.answer, question.type,
          context.read<ExamQuestionIndexCubit>().state);
    }
    context.read<ExamQuestionIndexCubit>().goToNextQuestion();
  }
}
