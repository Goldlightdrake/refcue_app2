import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_firebase_login/ui/screens/exam/exam.dart';
import 'package:flutter_svg/svg.dart';

class ExamCard extends StatelessWidget {
  final String examPath;
  final int color2;
  final int color1;
  final int quantity;
  final int time;

  ExamCard({this.time, this.quantity, this.color1, this.color2, this.examPath});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context)
            .push<void>(ExamScreen.route(amountQuestions: quantity)),
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Container(
              margin: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  colors: [
                    Color(color1),
                    Color(color2),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    offset: Offset(5, 10),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60.0,
                    margin: EdgeInsets.only(right: 20.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SvgPicture.asset('assets/icons/clock_icon.svg',
                            color: Colors.white, width: 30.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, left: 5.0),
                          child: Text(time.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 120.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                height: 60,
                                margin: EdgeInsets.only(left: 20.0),
                                child: SvgPicture.asset(
                                  elipsPath,
                                  color: Colors.white,
                                  width: 60.0,
                                )),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 20.0, left: 20.0, right: 20.0),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(quantity.toString() + ' PYTAŃ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 28)),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, bottom: 10.0),
                          child: SvgPicture.asset(
                            examPath,
                            width: 160,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
