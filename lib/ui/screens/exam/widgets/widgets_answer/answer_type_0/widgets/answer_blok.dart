import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:refcue_app/logic/exam_logic/exam_logic.dart';
import 'package:refcue_app/shared/const.dart';

Widget answerElement(String answerText) {
  return Builder(builder: (context) {
    bool answerPicked = context.watch<AnswerCubit>().state ==
            AnswerPicked(answer: answerText) &&
        (context.watch<AnswerCubit>().state as AnswerPicked).answer ==
            answerText;

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
                color: answerPicked
                    ? Colors.transparent
                    : Theme.of(context).shadowColor,
                offset: Offset(0, 5),
                blurRadius: 3.0,
              )
            ],
            color: answerPicked
                ? Theme.of(context).accentColor
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          answerText,
          style: kCaptionTextStyle.copyWith(
            color: answerPicked
                ? Colors.black
                : Theme.of(context).textTheme.bodyText1!.color,
            fontSize: ScreenUtil().setSp(kSpacingUnit.w * 2.5),
            fontWeight: answerPicked ? FontWeight.w600 : FontWeight.w100,
          ),
        ),
      ),
    );
  });
}
