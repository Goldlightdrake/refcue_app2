import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_firebase_login/shared/const.dart';

class ForUCard extends StatelessWidget {
  final String image;
  final Color color;

  ForUCard({this.image, this.color});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: kSpacingUnit.w * 18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: color,
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 10,
                  offset: Offset(5, 10)),
            ]),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: SvgPicture.asset(
              image,
              width: kSpacingUnit.w * 11,
            )),
      ),
    );
  }
}
