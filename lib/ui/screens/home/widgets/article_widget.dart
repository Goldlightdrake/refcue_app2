import 'package:flutter/material.dart';
import 'package:refcue_app/shared/const.dart';

import 'package:refcue_app/shared/functions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleWidget extends StatelessWidget {
  final int index;
  const ArticleWidget({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).shadowColor,
                  offset: Offset(2, 4),
                  blurRadius: 4)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: kSpacingUnit.w * 5.5,
              height: kSpacingUnit.w * 5.5,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  getIconForArticle(index + 1),
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            Text('Arytkuł ' + (index + 1).toString(),
                style: TextStyle(fontSize: kSpacingUnit.w * 2)),
            Icon(Icons.navigate_next)
          ],
        ));
  }
}
