import 'package:flutter/material.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:refcue_app/shared/functions.dart';
import 'package:flutter_svg/svg.dart';

class QuestionCategoriesView extends StatelessWidget {
  const QuestionCategoriesView({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => QuestionCategoriesView());
  }

  @override
  Widget build(BuildContext context) {
    var header = Column(
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
        Text("Stwórz własny test",
            style: kTitleTextStyle.copyWith(fontSize: kSpacingUnit.w * 2.5))
      ],
    );
    var listOfCategories = Expanded(
        child: ListView.builder(
      itemCount: 17,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).backgroundColor,
            ),
            margin: EdgeInsets.symmetric(vertical: 6),
            child: _CategorieListTile(
              index + 1,
            ));
      },
    ));

    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: kSpacingUnit.w * 5),
        header,
        SizedBox(height: kSpacingUnit.w * 2),
        listOfCategories,
      ],
    ));
  }
}

class _CategorieListTile extends StatelessWidget {
  final int index;
  const _CategorieListTile(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        activeTrackColor: Theme.of(context).primaryColor,
        activeColor: kAccentColor,
        title: Text(
          'Article ' + index.toString(),
          textAlign: TextAlign.center,
          style: kTitleTextStyle.copyWith(fontSize: kSpacingUnit.w * 2),
        ),
        value: true,
        secondary: SvgPicture.asset(getIconForArticle(index),
            width: kSpacingUnit.w * 4,
            color: Theme.of(context).iconTheme.color),
        onChanged: (bool value) {});
  }
}
