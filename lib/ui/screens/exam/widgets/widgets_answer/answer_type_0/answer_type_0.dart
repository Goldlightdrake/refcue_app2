import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/logic/bloc.dart';
import 'package:flutter_firebase_login/logic/cubit_answer/answer_cubit.dart';
import 'package:flutter_firebase_login/logic/cubit_answer_type_0/answer_type_0_cubit.dart';
import 'package:flutter_firebase_login/logic/cubit_answer_type_0/card_cubit.dart';
import 'package:flutter_firebase_login/logic/cubit_var/exam_var_cubit.dart';
import 'package:flutter_firebase_login/ui/screens/exam/widgets/widgets_answer/answer_type_0/widgets/answer_blok.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AnswerType0View extends StatelessWidget {
  const AnswerType0View({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
