import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/ui/screens/exam/widgets/submit_button.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_firebase_login/data/models/question.dart';
import 'package:flutter_firebase_login/logic/exam_logic/exam_logic.dart';
import 'package:flutter_firebase_login/shared/const.dart';

import 'answer_layout.dart';

class QuestionLayout extends StatelessWidget {
  final Question question;
  const QuestionLayout({
    Key key,
    @required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);

    var backgroundForHeader = CustomPaint(
      size: Size(
          800, 150), //You can Replace this with your desired WIDTH and HEIGHT
      painter: RPSCustomPainter(context: context),
    );

    var header = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: kSpacingUnit.w * 1),
            IconButton(
              onPressed: () => context.read<ExamQuestionIndexCubit>().state == 0
                  ? Navigator.of(context).pop<void>()
                  : context.read<ExamQuestionIndexCubit>().goToPrevQuestion(),
              icon: context.watch<ExamQuestionIndexCubit>().state == 0
                  ? Icon(Icons.home)
                  : Icon(Icons.arrow_back),
              iconSize: ScreenUtil().setSp(kSpacingUnit.w * 4),
            ),
            Image.asset(
                ThemeProvider.of(context).brightness == Brightness.dark
                    ? logoDarkPath
                    : logoPath,
                width: ScreenUtil().setSp(kSpacingUnit.w * 14)),
            BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                final String minutesStr =
                    ((state.duration / 60) % 60).floor().toString();

                final String secondsStr =
                    (state.duration % 60).floor().toString().padLeft(2, '0');
                Color colorOfTimer = Colors.white;
                if (state.duration < 60) {
                  colorOfTimer = kAccentColor;
                } else if (state.duration < 10) {
                  colorOfTimer = Colors.redAccent;
                }
                return Text(
                  '$minutesStr:$secondsStr',
                  style: TextStyle(
                      color: colorOfTimer,
                      fontFamily: 'Roboto',
                      fontSize: kSpacingUnit.w * 2),
                );
              },
            ),
            // Icon(Icons.timer, size: ScreenUtil().setSp(kSpacingUnit.w * 4)),
            SizedBox(width: kSpacingUnit.w * 1),
          ],
        ),
        SizedBox(height: kSpacingUnit.w * 1.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: kSpacingUnit.w * 20,
              height: kSpacingUnit.w * 3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Stack(children: [
                Container(
                  width: (kSpacingUnit.w *
                          20 /
                          context.watch<ExamBloc>().maxIndex) *
                      (context.watch<ExamQuestionIndexCubit>().state + 1),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ]),
            ),
            SizedBox(width: kSpacingUnit.w * 1),
            Text(
                (context.watch<ExamQuestionIndexCubit>().state + 1).toString() +
                    "/" +
                    context.watch<ExamBloc>().maxIndex.toString(),
                style: TextStyle(fontSize: kSpacingUnit.w * 2))
          ],
        )
      ],
    );

    var questionText = Container(
      alignment: Alignment.topCenter,
      // color: Colors.white,
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setSp(kSpacingUnit.w * 4)),
      height: kSpacingUnit.w * 25,
      child: SingleChildScrollView(
        child: Text(
          question.questionText,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600),
        ),
      ),
    );

    //Building widget
    return BlocProvider(
      create: (context) => CardsCubit(),
      child: Scaffold(
          body: Column(
        children: [
          Stack(
            children: [
              backgroundForHeader,
              header,
            ],
            alignment: Alignment.center,
          ),
          SizedBox(height: kSpacingUnit.w * 8),
          questionText,
          SizedBox(height: kSpacingUnit.w * 2),
          BlocListener<BuildingQuestionLayoutCubit,
              BuildingQuestionLayoutState>(
            listener: (context, state) {
              var userAnswer = context.read<AnswerCubit>().userAnswersList[
                  context.read<ExamQuestionIndexCubit>().state];
              if (userAnswer != "-") {
                if (userAnswer[0] == "t") {
                  userAnswer = "tak";
                  context.read<AnswerCubit>().pickAnswer(userAnswer);
                } else if (userAnswer[0] == "n") {
                  userAnswer = "nie";
                  context.read<AnswerCubit>().pickAnswer(userAnswer);
                } else {
                  context.read<AnswerCubit>().pickAnswer(userAnswer[0]);
                  if (userAnswer[1] != '0') {
                    context
                        .read<CardsCubit>()
                        .setYellowCards(int.parse(userAnswer[1]));
                  }
                  if (userAnswer[2] != '0') {
                    context
                        .read<CardsCubit>()
                        .setRedCards(int.parse(userAnswer[2]));
                  }
                }
              }
            },
            child: Container(
              height: kSpacingUnit.w * 22,
              child: AnswerLayout(
                key: UniqueKey(),
                typeOfAnswer: question.type,
              ),
            ),
          ),
          Builder(
            builder: (context) => RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () {
                  submitButtonAction(context, question);
                },
                child: Icon(Icons.arrow_forward, color: Colors.white)),
          )
        ],
      )),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  final BuildContext context;
  RPSCustomPainter({
    this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Theme.of(context).backgroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.quadraticBezierTo(
        size.width * 0.01, size.height * 0.99, size.width * 0.13, size.height);
    path_0.cubicTo(size.width * 0.13, size.height * 1.00, size.width * 0.87,
        size.height * 1.01, size.width * 0.88, size.height);
    path_0.quadraticBezierTo(
        size.width * 0.99, size.height * 1.00, size.width, 0);
    path_0.lineTo(0, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
    canvas.drawShadow(path_0.shift(Offset(0, 5)),
        Theme.of(context).shadowColor.withAlpha(50), 1.0, true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
