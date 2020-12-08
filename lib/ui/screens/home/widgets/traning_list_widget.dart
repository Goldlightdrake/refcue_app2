import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForUCard extends StatelessWidget {
  final String image;
  final Color color;

  ForUCard({this.image, this.color});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 100.0,
        height: 170.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: color,
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 10,
                  offset: Offset(5, 10)),
            ]),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: SvgPicture.asset(
              image,
              width: 300,
            )),
      ),
    );
  }
}
