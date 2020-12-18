import 'package:flutter/material.dart';

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
      return Column(
        children: [],
      );
    }
    // 1 - typ pytan z odpowiedziami np. a,b,c
    else if (typeOfAnswer == 1) {
    }
    // 2 - typ pytan z odpowiedziami tak/nie
    else {}
    return Center(
        child: Icon(
      Icons.error,
      semanticLabel: "Coś poszło nie tak ... 🥶",
    ));
  }
}
