import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/logic/exam_logic/exam_logic.dart';

import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_firebase_login/shared/functions.dart';
import 'package:flutter_firebase_login/ui/screens/exam/widgets/exam_finished_extended.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinishedExamScreen extends StatelessWidget {
  const FinishedExamScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);

    final examFinishedState = context.watch<ExamBloc>().state as ExamFinished;

    final userAnswerList = examFinishedState.userAnswers;
    final questionsList = examFinishedState.questionsList;
    final timerTime = context.watch<TimerBloc>().state.duration;

    final String minutesStr = ((timerTime / 60) % 60).floor().toString();

    final String secondsStr =
        (timerTime % 60).floor().toString().padLeft(2, '0');

    var header = Padding(
        padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(greatViewOfScore(examFinishedState.userScore),
                    style: TextStyle(
                        fontSize: kSpacingUnit.w * 7.5, fontFamily: 'Roboto')),
                Text("/" + examFinishedState.examMaxScore.toString(),
                    style: TextStyle())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.timer),
                    Text(
                      '$minutesStr:$secondsStr',
                      style: TextStyle(
                          fontFamily: 'Roboto', fontSize: kSpacingUnit.w * 2),
                    )
                  ],
                ),
                SizedBox(width: kSpacingUnit.w * 1),
                Container(
                  alignment: Alignment.center,
                  width: 60,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    onPressed: () => null,
                    child: Icon(Icons.share),
                  ),
                ),
                SizedBox(
                  width: kSpacingUnit.w * 1,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 60,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    onPressed: () => Navigator.of(context).pop<void>(),
                    child: Icon(Icons.home),
                  ),
                ),
              ],
            )
          ],
        ));

    var answerList = Expanded(
      child: ListView.builder(
        itemCount: questionsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).push<void>(
              ExamFinishedExtended.route(
                  questionsList[index],
                  userAnswerList[index],
                  Color(colorOfAnswer(
                      context.read<AnswerCubit>().pointsForQuestions[index]))),
            ),
            child: Stack(alignment: Alignment.centerRight, children: [
              Container(
                  height: kSpacingUnit.w * 9,
                  margin: EdgeInsets.symmetric(
                      vertical: kSpacingUnit.w * 1,
                      horizontal: kSpacingUnit.w * 1.5),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: kSpacingUnit.w * 5,
                        child: Text((index + 1).toString(),
                            style: TextStyle(
                                fontSize: kSpacingUnit.w * 3.5,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                          width: kSpacingUnit.w * 20,
                          child: Text(firstFewWords(
                              questionsList[index].questionText))),
                      SizedBox(width: 20)
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(right: 5),
                height: kSpacingUnit.w * 2.8,
                width: kSpacingUnit.w * 2.8,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        offset: Offset(0, 1),
                        blurRadius: 1.0,
                      )
                    ],
                    color: Color(colorOfAnswer(
                        context.read<AnswerCubit>().pointsForQuestions[index])),
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(Icons.navigate_next, color: Colors.white),
              ),
            ]),
          );
        },
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: kSpacingUnit.w * 7,
          ),
          header,
          answerList
        ],
      ),
    );
  }
}
