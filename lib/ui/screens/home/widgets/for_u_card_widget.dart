import 'package:flutter/material.dart';
import 'package:refcue_app/data/repositories/exam_repo.dart';
import 'package:refcue_app/ui/screens/home/view/custom_exam/custom_exam_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refcue_app/shared/const.dart';

class ForUCard extends StatelessWidget {
  final String? image;
  final Color? color;
  final String? path;

  ForUCard({this.image, this.color, this.path});

  Route<dynamic>? navigationNames(String? where) {
    switch (path) {
      case 'customexam':
        return CustomExamView.route();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ExamRepository(amountOfQuestions: 5).customListOfQuestion(['12']);
        Navigator.of(context).push<void>(navigationNames(path)!);
      },
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
              image!,
              width: kSpacingUnit.w * 11,
            )),
      ),
    );
  }
}
