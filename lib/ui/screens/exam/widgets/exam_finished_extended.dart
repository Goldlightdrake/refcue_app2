import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:flutter_firebase_login/data/models/question.dart';
import 'package:flutter_firebase_login/shared/const.dart';

import 'answer_cards_view.dart';

class ExamFinishedExtended extends StatelessWidget {
  const ExamFinishedExtended(
      {Key key, this.question, this.userAnswer, this.colorOfAnswer})
      : super(key: key);

  final Question question;
  final String userAnswer;
  final Color colorOfAnswer;

  static Route route(
      Question question, String userAnswer, Color colorOfAnswer) {
    return MaterialPageRoute<void>(
        builder: (_) => ExamFinishedExtended(
              question: question,
              userAnswer: userAnswer,
              colorOfAnswer: colorOfAnswer,
            ));
  }

  @override
  Widget build(BuildContext context) {
    var header = Padding(
        padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 3),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.of(context).pop<void>(),
                icon: Icon(LineAwesomeIcons.arrow_left),
                iconSize: ScreenUtil().setSp(kSpacingUnit.w * 3),
              ),
              Image.asset(
                  ThemeProvider.of(context).brightness == Brightness.dark
                      ? logoDarkPath
                      : logoPath,
                  width: kSpacingUnit.w * 12),
            ]));

    var questionText = Container(
        margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(kSpacingUnit.w * 4)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              child: Row(
            children: [
              Text('Treść pytania',
                  style: TextStyle(fontSize: kSpacingUnit.w * 1.5)),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.question_answer),
            ],
          )),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Container(
            width: 100,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 1.8),
          Container(
            height: kSpacingUnit.w * 17,
            child: SingleChildScrollView(
              child: Text(
                question.questionText,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Artkuły',
                          style: TextStyle(fontSize: kSpacingUnit.w * 1.5)),
                      Icon(Icons.bookmark_rounded),
                      Text(question.article,
                          style: TextStyle(fontSize: kSpacingUnit.w * 2))
                    ],
                  )),
            ],
          ),
        ]));

    var answer = Container(
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 1.5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(kSpacingUnit.w * 1),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(blurRadius: 6.0, color: Color(0xee39FF14))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('Poprawna odpowiedź',
                        style: TextStyle(fontSize: kSpacingUnit.w * 1.4)),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.check)
                  ],
                ),
                SizedBox(height: kSpacingUnit.w * 0.5),
                Container(
                  width: 140,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                ),
                SizedBox(height: kSpacingUnit.w * 1.5),
                Builder(builder: (context) {
                  if (question.type == 0) {
                    final String resumption = question.answer[0];
                    final String yellowCards = question.answer[1];
                    final String redCards = question.answer[2];
                    return AnswerCardsView(resumption, yellowCards, redCards);
                  }
                  return Text(
                      question.answer[0].toUpperCase() +
                          question.answer.substring(1),
                      style: TextStyle(fontSize: kSpacingUnit.w * 2.5));
                })
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(kSpacingUnit.w * 1),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 6.0,
                      offset: Offset(0, 0),
                      color: colorOfAnswer)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('Twoja odpowiedź'),
                    SizedBox(width: 7),
                    Icon(
                      Icons.person,
                    )
                  ],
                ),
                SizedBox(height: kSpacingUnit.w * 0.5),
                Container(
                  width: 120,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                ),
                SizedBox(height: kSpacingUnit.w * 1.5),
                Builder(builder: (context) {
                  if (question.type == 0) {
                    final String resumption = userAnswer[0];
                    final String yellowCards = userAnswer[1];
                    final String redCards = userAnswer[2];
                    return AnswerCardsView(resumption, yellowCards, redCards);
                  }
                  return Text(
                      userAnswer[0].toUpperCase() + userAnswer.substring(1),
                      style: TextStyle(fontSize: kSpacingUnit.w * 2.5));
                })
              ],
            ),
          ),
        ],
      ),
    );

    var substantiation = Container(
        margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(kSpacingUnit.w * 4)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              child: Row(
            children: [
              Text('Dlaczego?',
                  style: TextStyle(fontSize: kSpacingUnit.w * 1.5)),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.fact_check),
            ],
          )),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Container(
            width: 80,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 1.8),
          Container(
            height: kSpacingUnit.w * 14,
            child: SingleChildScrollView(
              child: Text(
                question.questionText,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ]));

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: kSpacingUnit.w * 5),
          header,
          SizedBox(height: kSpacingUnit.w * 5),
          questionText,
          SizedBox(height: kSpacingUnit.w * 4),
          answer,
          SizedBox(height: kSpacingUnit.w * 4),
          substantiation
        ],
      ),
    );
  }
}
