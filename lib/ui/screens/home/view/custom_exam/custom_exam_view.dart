import 'package:flutter/material.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CustomExamView extends StatelessWidget {
  const CustomExamView({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CustomExamView());
  }

  @override
  Widget build(BuildContext context) {
    var header = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 1),
        IconButton(
          onPressed: () => Navigator.of(context).pop<void>(),
          icon: Icon(LineAwesomeIcons.arrow_left),
          iconSize: ScreenUtil().setSp(kSpacingUnit.w * 3),
        ),
        Padding(
          padding: EdgeInsets.only(left: kSpacingUnit.w * 5),
          child: Text("Stwórz własny test",
              style: kTitleTextStyle.copyWith(fontSize: kSpacingUnit.w * 2.5)),
        )
      ],
    );

    Widget _headerForSection({required String sectionName}) {
      final _orangeColor = Color(0xffFFC107);

      return Container(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(sectionName,
                    style: TextStyle(fontSize: kSpacingUnit.w * 1.6)),
              ],
            ),
            SizedBox(height: 5),
            Container(
              width: 300,
              height: 3,
              decoration: BoxDecoration(
                  color: _orangeColor, borderRadius: BorderRadius.circular(28)),
            ),
          ],
        ),
      );
    }

    var listOfCategories = Container(
      height: kSpacingUnit.w * 25,
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

    var timeOfExamSelection = Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _TimeSelection(),
            _TimeSelection(),
            _TimeSelection(),
          ],
        ));

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(height: kSpacingUnit.w * 5),
          header,
          SizedBox(height: kSpacingUnit.w * 4),
          _headerForSection(sectionName: 'Wybierz artykuły'),
          listOfCategories,
          _headerForSection(sectionName: 'Wybierz czas'),
          SizedBox(
            height: kSpacingUnit.w * 4,
          ),
          timeOfExamSelection,
        ],
      ),
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

class _TimeSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: kSpacingUnit.w * 10,
      height: kSpacingUnit.w * 12,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Theme.of(context).cardColor),
    );
  }
}
