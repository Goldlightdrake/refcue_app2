import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase_login/logic/exam_logic/exam_logic.dart';

Widget answerType2Element(String answerText) {
  return Builder(builder: (context) {
    final answerCubitState = context.watch<AnswerCubit>().state;

    bool answerPicked = answerCubitState == AnswerPicked(answer: answerText) &&
        (answerCubitState as AnswerPicked).answer == answerText;

    return GestureDetector(
      onTap: () => context.read<AnswerCubit>().pickAnswer(answerText),
      child: Container(
        alignment: Alignment.center,
        width: kSpacingUnit.w * 12,
        height: kSpacingUnit.w * 8,
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
          answerText[0].toUpperCase() + answerText.substring(1),
          style: kCaptionTextStyle.copyWith(
            color: answerPicked
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1.color,
            fontSize: ScreenUtil().setSp(kSpacingUnit.w * 3),
            fontWeight: answerPicked ? FontWeight.w600 : FontWeight.w100,
          ),
        ),
      ),
    );
  });
}

// Widget answerType2Element(String answerText) {
//   return BlocBuilder<AnswerCubit, AnswerState>(builder: (context, state) {
//     if (state is AnswerPicked) {
//       return GestureDetector(
//         onTap: () => context.read<AnswerCubit>().pickAnswer(answerText),
//         child: Container(
//           alignment: Alignment.center,
//           width: kSpacingUnit.w * 12,
//           height: kSpacingUnit.w * 8,
//           margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 0.5),
//           decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: state.answer == answerText
//                       ? Colors.transparent
//                       : Theme.of(context).shadowColor,
//                   offset: Offset(0, 5),
//                   blurRadius: 3.0,
//                 )
//               ],
//               color: state.answer == answerText
//                   ? Colors.blue
//                   : Theme.of(context).cardColor,
//               borderRadius: BorderRadius.all(Radius.circular(8))),
//           child: Text(answerText[0].toUpperCase() + answerText.substring(1),
//               style: kCaptionTextStyle.copyWith(
//                 fontSize: kSpacingUnit.w * 3,
//                 fontWeight: state.answer == answerText
//                     ? FontWeight.w600
//                     : FontWeight.w100,
//               )),
//         ),
//       );
//     }
//     return GestureDetector(
//       onTap: () => context.read<AnswerCubit>().pickAnswer(answerText),
//       child: Container(
//         alignment: Alignment.center,
//         width: kSpacingUnit.w * 12,
//         height: kSpacingUnit.w * 8,
//         margin: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 0.5),
//         decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Theme.of(context).shadowColor,
//                 offset: Offset(0, 5),
//                 blurRadius: 3.0,
//               )
//             ],
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.all(Radius.circular(8))),
//         child: Text(answerText[0].toUpperCase() + answerText.substring(1),
//             style: kCaptionTextStyle.copyWith(fontSize: kSpacingUnit.w * 3)),
//       ),
//     );
//   });
// }
