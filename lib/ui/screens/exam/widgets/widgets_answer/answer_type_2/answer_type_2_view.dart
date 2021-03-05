import 'package:flutter/material.dart';
import 'package:refcue_app/ui/screens/exam/widgets/widgets_answer/answer_type_2/widgets/answer_blok.dart';

class AnswerType2View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        answerType2Element('tak'),
        answerType2Element('nie'),
      ],
    );
  }
}
