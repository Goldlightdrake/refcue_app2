import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/ui/screens/exam/widgets/widgets_answer/answer_type_0/answer_type_0_app.dart';
import 'package:flutter_firebase_login/ui/screens/exam/widgets/widgets_answer/answer_type_2/answer_type_2_view.dart';

class AnswerLayout extends StatelessWidget {
  final int typeOfAnswer;
  const AnswerLayout({
    Key key,
    @required this.typeOfAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 0 - typ pytan z odpowiedzami np.P,++
    if (typeOfAnswer == 0) {
      return AnswerType0App();
    }
    // 1 - typ pytan z odpowiedziami np. a,b,c
    else if (typeOfAnswer == 1) {
    }
    // 2 - typ pytan z odpowiedziami tak/nie
    else if (typeOfAnswer == 2) {
      return AnswerType2View();
    }
    return Center(
        child: Icon(
      Icons.error,
      semanticLabel: "Coś poszło nie tak ... 🥶",
    ));
  }
}
