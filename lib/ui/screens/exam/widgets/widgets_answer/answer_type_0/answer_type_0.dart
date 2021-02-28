import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_firebase_login/logic/exam_logic/exam_logic.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_firebase_login/ui/screens/exam/widgets/widgets_answer/answer_type_0/widgets/answer_blok.dart';

class AnswerType0View extends StatelessWidget {
  const AnswerType0View({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goToCardsWidget = GestureDetector(
      onTap: () => context.read<AnswerType0Cubit>().goToCards(),
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
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            overflow: Overflow.visible,
            children: [
              Positioned(
                  child: Container(
                height: 20,
                width: 20,
              )),
              Positioned(
                left: -7,
                child: RotationTransition(
                    turns: AlwaysStoppedAnimation(-20 / 360),
                    child: Container(height: 20, width: 15, color: Colors.red)),
              ),
              Positioned(
                  left: 7,
                  child: RotationTransition(
                      turns: AlwaysStoppedAnimation(20 / 360),
                      child: Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 15,
                          color: Colors.yellow))),
            ],
          )),
    );

    var answerPicked = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                answerElement('G'),
                answerElement('B'),
                answerElement('P'),
                answerElement('K'),
              ],
            ),
            SizedBox(
              height: kSpacingUnit.w * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                answerElement('J'),
                answerElement('S'),
                answerElement('Br'),
                answerElement('W'),
              ],
            ),
            SizedBox(
              height: kSpacingUnit.w * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                answerElement('R'),
                answerElement('Z'),
                answerElement('Rb'),
              ],
            ),
          ],
        ),
        IconButton(
            onPressed: () => context.read<AnswerType0Cubit>().goToCards(),
            icon: Icon(LineAwesomeIcons.arrow_right),
            iconSize: kSpacingUnit.w * 3)
      ],
    );

    var answerNotPicked = Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            answerElement('G'),
            answerElement('B'),
            answerElement('P'),
            answerElement('K'),
          ],
        ),
        SizedBox(
          height: kSpacingUnit.w * 1.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            answerElement('J'),
            answerElement('S'),
            answerElement('Br'),
            answerElement('W'),
          ],
        ),
        SizedBox(
          height: kSpacingUnit.w * 1.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            answerElement('R'),
            answerElement('Z'),
            answerElement('Rb'),
            goToCardsWidget,
          ],
        ),
      ],
    );

    return BlocBuilder<AnswerCubit, AnswerState>(
      builder: (context, state) {
        return Column(
          children: [
            AnimatedSwitcher(
                duration: Duration(milliseconds: 100),
                child: state is AnswerPicked ? answerPicked : answerNotPicked),
          ],
        );
      },
    );
  }
}
