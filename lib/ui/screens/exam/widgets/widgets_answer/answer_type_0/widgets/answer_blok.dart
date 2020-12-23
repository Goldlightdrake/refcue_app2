import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/logic/cubit_answer/answer_cubit.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget answerElement(String answerText) {
  return BlocBuilder<AnswerCubit, AnswerState>(builder: (context, state) {
    if (state is AnswerPicked) {
      return GestureDetector(
        onTap: () => context.read<AnswerCubit>().pickAnswer(answerText),
        child: Container(
          alignment: Alignment.center,
          width: kSpacingUnit.w * 6.5,
          height: kSpacingUnit.w * 5.5,
          margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 0.5),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: state.answer == answerText
                      ? Colors.transparent
                      : Theme.of(context).shadowColor,
                  offset: Offset(0, 5),
                  blurRadius: 3.0,
                )
              ],
              color: state.answer == answerText
                  ? Colors.blue
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text(answerText,
              style: kCaptionTextStyle.copyWith(
                fontSize: kSpacingUnit.w * 2.5,
                fontWeight: state.answer == answerText
                    ? FontWeight.w600
                    : FontWeight.w100,
              )),
        ),
      );
    }
    return GestureDetector(
      onTap: () => context.read<AnswerCubit>().pickAnswer(answerText),
      child: Container(
        alignment: Alignment.center,
        width: kSpacingUnit.w * 6.5,
        height: kSpacingUnit.w * 5.5,
        margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 0.5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: Offset(0, 5),
                blurRadius: 3.0,
              )
            ],
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(answerText,
            style: kCaptionTextStyle.copyWith(fontSize: kSpacingUnit.w * 2.5)),
      ),
    );
  });
}
