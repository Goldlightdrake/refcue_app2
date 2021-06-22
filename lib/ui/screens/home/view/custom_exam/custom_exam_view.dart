import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:refcue_app/logic/custom_exam_logic/cubit/user_choice_cubit.dart';

import 'package:refcue_app/shared/const.dart';

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
      child: Builder(builder: (context) {
        context.watch<UserChoiceCubit>();
        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 17,
          itemBuilder: (context, index) =>
              _ArticleChip(index, key: UniqueKey()),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 2,
            crossAxisCount: 5,
          ),
        );
      }),
    );

    var timeOfExamSelection = Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _TimeSelection(time: 5),
          _TimeSelection(time: 10),
          _TimeSelection(time: 30),
        ]));

    return BlocProvider(
      create: (context) => UserChoiceCubit(),
      child: Scaffold(
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
      )),
    );
  }
}

class _ArticleChip extends StatelessWidget {
  final int index;
  const _ArticleChip(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      final userChoiceCubit = context.watch<UserChoiceCubit>();
      final isSelected = userChoiceCubit.state.articles[index];
      return FilterChip(
          showCheckmark: false,
          backgroundColor: isSelected
              ? Theme.of(context).cardColor
              : Theme.of(context).backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 3),
          avatar: Icon(isSelected ? Icons.check : Icons.close,
              color: isSelected
                  ? Colors.green
                  : Theme.of(context).iconTheme.color),
          label: Text((index + 1).toString()),
          onSelected: (bool) => userChoiceCubit.chooseArticle(index));
    });
  }
}

class _TimeSelection extends StatelessWidget {
  final int time;
  const _TimeSelection({
    Key? key,
    required this.time,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userChoiceCubit = context.watch<UserChoiceCubit>();
    final isSelected = userChoiceCubit.state.time == time ? true : false;
    EdgeInsets padding = EdgeInsets.symmetric(horizontal: 25, vertical: 15);
    if (time >= 10) {
      padding = EdgeInsets.symmetric(horizontal: 15, vertical: 15);
    }
    return GestureDetector(
      onTap: () => userChoiceCubit.chooseTime(time),
      child: Container(
          alignment: Alignment.center,
          width: kSpacingUnit.w * 10,
          height: kSpacingUnit.w * 13,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: isSelected
                  ? Theme.of(context).cardColor
                  : Theme.of(context).backgroundColor),
          child: DashedCircle(
            color: isSelected ? kAccentColor : Colors.grey,
            dashes: 3,
            gapSize: 10,
            child: Padding(
              padding: padding,
              child: Text(time.toString(),
                  style: TextStyle(fontSize: kSpacingUnit.w * 3.5)),
            ),
          )),
    );
  }
}
