import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:refcue_app/data/models/question.dart';
import 'package:refcue_app/shared/const.dart';

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
          //Widget poprawnej odpowiedzi znajdujący się po lewej stronie
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
                    if (question.answer.length > 3) {
                      String resumption =
                          question.answer[0] + question.answer[1];
                      String yellowCards = question.answer[2];
                      String redCards = question.answer[3];
                      return AnswerCardsView(resumption, yellowCards, redCards);
                    } else {
                      String resumption = question.answer[0];
                      String yellowCards = question.answer[1];
                      String redCards = question.answer[2];
                      return AnswerCardsView(resumption, yellowCards, redCards);
                    }
                  }
                  return Text(
                      question.answer[0].toUpperCase() +
                          question.answer.substring(1),
                      style: TextStyle(fontSize: kSpacingUnit.w * 2.2));
                })
              ],
            ),
          ),
          //Widget odpowiedzi użytkownika znajdujący się po prawej stornie
          Container(
            padding: EdgeInsets.all(kSpacingUnit.w * 1),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6.0,
                    color: colorOfAnswer,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('Twoja odpowiedź',
                        style: TextStyle(fontSize: kSpacingUnit.w * 1.4)),
                    SizedBox(width: 5),
                    Icon(
                      Icons.person,
                    )
                  ],
                ),
                SizedBox(height: kSpacingUnit.w * 0.5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    width: 140,
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                ),
                SizedBox(height: kSpacingUnit.w * 1.5),
                Builder(builder: (context) {
                  if (question.type == 0) {
                    if (userAnswer[0] != '-') {
                      if (userAnswer.length > 3) {
                        String resumption = userAnswer[0] + userAnswer[1];
                        String yellowCards = userAnswer[2];
                        String redCards = userAnswer[3];
                        return AnswerCardsView(
                            resumption, yellowCards, redCards);
                      } else {
                        String resumption = userAnswer[0];
                        String yellowCards = userAnswer[1];
                        String redCards = userAnswer[2];
                        return AnswerCardsView(
                            resumption, yellowCards, redCards);
                      }
                    } else {
                      return Container(
                        height: kSpacingUnit.w * 5,
                        child: Text('-',
                            style: TextStyle(fontSize: kSpacingUnit.w * 3.5)),
                      );
                    }
                  }
                  return Text(
                      userAnswer[0].toUpperCase() + userAnswer.substring(1),
                      style: TextStyle(fontSize: kSpacingUnit.w * 2.2));
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
                question.substantiation,
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
