import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

questionAnswerLegend(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: kSpacingUnit.w * 40,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white),
              ),
              SizedBox(
                height: kSpacingUnit.w * 2,
              ),
              Text('Legenda',
                  style:
                      kTitleTextStyle.copyWith(fontSize: kSpacingUnit.w * 2)),
              SizedBox(height: kSpacingUnit.w * 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: kSpacingUnit.w * 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('G - grać dalej',
                            style: kTitleTextStyle.copyWith(
                                fontSize: kSpacingUnit.w * 1.7)),
                        Text('P - rzut wolny pośredni',
                            style: kTitleTextStyle.copyWith(
                                fontSize: kSpacingUnit.w * 1.7)),
                        Text('J - jeszcze raz',
                            style: kTitleTextStyle.copyWith(
                                fontSize: kSpacingUnit.w * 1.7)),
                        Text('Br - bramka',
                            style: kTitleTextStyle.copyWith(
                                fontSize: kSpacingUnit.w * 1.7)),
                        Text('R - rzut rożny',
                            style: kTitleTextStyle.copyWith(
                                fontSize: kSpacingUnit.w * 1.7)),
                        Text('Rb - rzut od bramki',
                            style: kTitleTextStyle.copyWith(
                                fontSize: kSpacingUnit.w * 1.7)),
                      ],
                    ),
                  ),
                  Container(
                    height: kSpacingUnit.w * 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('B - rzut wolny bezpośredni',
                            style: kTitleTextStyle.copyWith(
                                fontSize: kSpacingUnit.w * 1.7)),
                        Text('K - rzut karny',
                            style: kTitleTextStyle.copyWith(
                                fontSize: kSpacingUnit.w * 1.7)),
                        Text('S - rzut sędziowski',
                            style: kTitleTextStyle.copyWith(
                                fontSize: kSpacingUnit.w * 1.7)),
                        Text('W - wrzut',
                            style: kTitleTextStyle.copyWith(
                                fontSize: kSpacingUnit.w * 1.7)),
                        Text('Z - zakończenie',
                            style: kTitleTextStyle.copyWith(
                                fontSize: kSpacingUnit.w * 1.7)),
                        SizedBox(height: kSpacingUnit.w * 1.7),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      });
}
