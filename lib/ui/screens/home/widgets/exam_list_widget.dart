import 'package:flutter/material.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:refcue_app/ui/screens/exam/exam.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamCard extends StatelessWidget {
  final String? examPath;
  final int? color2;
  final int? color1;
  final int? quantity;
  final int? time;

  ExamCard({this.time, this.quantity, this.color1, this.color2, this.examPath});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context)
            .push<void>(ExamScreen.route(amountQuestions: quantity)),
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: kSpacingUnit.w * 1.5, vertical: kSpacingUnit.w * 1),
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                colors: [
                  Color(color1!),
                  Color(color2!),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset('assets/icons/clock_icon.svg',
                        color: Colors.white, width: kSpacingUnit.w * 3),
                    Text(time.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: kSpacingUnit.w * 3,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: kSpacingUnit.w * 3),
                            SvgPicture.asset(
                              elipsPath,
                              color: Colors.white,
                              width: kSpacingUnit.w * 6,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: kSpacingUnit.w * 1,
                            left: kSpacingUnit.w * 1,
                            right: kSpacingUnit.w * 1,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            ' ' + quantity.toString() + ' PYTAŃ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: kSpacingUnit.w * 3.5),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: kSpacingUnit.w * 1,
                      ),
                      child: SvgPicture.asset(
                        examPath!,
                        width: kSpacingUnit.w * 15,
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}
