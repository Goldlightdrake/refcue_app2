import 'package:flutter/material.dart';
// First test type answers widget

Widget firstTestCard(
    {BuildContext context,
    int index,
    String decision,
    Function userAnswer,
    bool isSelected,
    Function clickedAnswer}) {
  return GestureDetector(
    onTap: () {
      clickedAnswer(index);
      userAnswer(decision);
    },
    child: Container(
        height: 60.0,
        width: 45.0,
        margin: EdgeInsets.all(8.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[500] : Colors.white,
          border: Border.all(color: Colors.black45, width: 1),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 3,
              spreadRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(decision,
            style: TextStyle(
                fontSize: 32.0,
                color: isSelected ? Colors.white : Colors.black45,
                decoration: TextDecoration.none))),
  );
}

Widget thirdTestCard(
    {BuildContext context,
    int index,
    String decision,
    Function userAnswer,
    bool isSelected,
    Function clickedAnswer}) {
  return GestureDetector(
    onTap: () {
      clickedAnswer(index);
      userAnswer(decision);
    },
    child: Container(
        height: 80.0,
        width: 120.0,
        margin: EdgeInsets.all(8.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(color: Colors.black45, width: 1),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 3,
              spreadRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(decision,
            style: TextStyle(
                fontSize: 32.0,
                color: isSelected ? Colors.white : Colors.black45,
                decoration: TextDecoration.none))),
  );
}

Widget next({Function onClickAction, Function checkingAnswer}) {
  return GestureDetector(
    onTap: () {
      checkingAnswer();
      onClickAction();
      print('next');
    },
    child: Container(
        margin: EdgeInsets.all(8.0),
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black45, width: 1),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[350],
              // blurRadius: 10,
              offset: Offset(5, 7),
            ),
          ],
        ),
        child: Icon(Icons.navigate_next, color: Colors.black, size: 40.0)),
  );
}

Widget secondTypeCard({String decision}) {
  return Container(
    alignment: Alignment.center,
    height: 60.0,
    width: 60.0,
    child:
        Text(decision, style: TextStyle(fontFamily: "Roboto", fontSize: 32.0)),
  );
}
