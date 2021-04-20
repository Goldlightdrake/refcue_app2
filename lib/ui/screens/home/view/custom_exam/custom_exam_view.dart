import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:refcue_app/shared/functions.dart';
import 'package:flutter_svg/svg.dart';

class CustomExamView extends StatelessWidget {
  const CustomExamView({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CustomExamView());
  }

  @override
  Widget build(BuildContext context) {
    var header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: kSpacingUnit.w * 3),
            IconButton(
              onPressed: () => Navigator.of(context).pop<void>(),
              icon: Icon(LineAwesomeIcons.arrow_left),
              iconSize: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ],
        ),
        SizedBox(
          height: kSpacingUnit.w * 4,
        ),
        Padding(
          padding: EdgeInsets.only(left: kSpacingUnit.w * 5),
          child: Text("Stwórz własny test",
              style: kTitleTextStyle.copyWith(fontSize: kSpacingUnit.w * 2.5)),
        )
      ],
    );
    var listOfCategories = Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: kSpacingUnit.w * 30,
      width: double.infinity,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 17,
        itemBuilder: (context, index) => _ArticleChip(index + 1),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 2,
          crossAxisCount: 5,
        ),
      ),
    );

    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: kSpacingUnit.w * 5),
        header,
        listOfCategories,
      ],
    ));
  }
}

class _ArticleChip extends StatelessWidget {
  final int index;
  const _ArticleChip(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
        selected: false,
        showCheckmark: false,
        padding: EdgeInsets.symmetric(horizontal: 3),
        avatar: Icon(Icons.close),
        label: Text(index.toString()),
        onSelected: (bool) => null);
  }
}
