import 'package:flutter/material.dart';
import 'package:refcue_app/logic/exam_logic/exam_logic.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswerType0CardsView extends StatelessWidget {
  const AnswerType0CardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: kSpacingUnit.w * 2),
            IconButton(
                onPressed: () => context.read<AnswerType0Cubit>().goBack(),
                icon: Icon(LineAwesomeIcons.arrow_left),
                iconSize: kSpacingUnit.w * 3),
            SizedBox(width: kSpacingUnit.w * 4),
            Row(
              children: [
                Column(
                  children: [
                    TextButton(
                      onPressed: () =>
                          context.read<CardsCubit>().addYellowCard(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Icon(Icons.add,
                            color: Theme.of(context).iconTheme.color),
                      ),
                    ),
                    Container(
                      width: kSpacingUnit.w * 6,
                      height: kSpacingUnit.w * 10,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xeeEBDE34),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).shadowColor,
                            offset: Offset(0, 5),
                            blurRadius: 3.0,
                          )
                        ],
                      ),
                      child: Builder(builder: (context) {
                        return Text(
                          context
                              .watch<CardsCubit>()
                              .state
                              .yellowCards
                              .toString(),
                          style: TextStyle(
                            fontSize: kSpacingUnit.w * 3,
                          ),
                        );
                      }),
                    ),
                    TextButton(
                      onPressed: () =>
                          context.read<CardsCubit>().removeYellowCard(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Icon(Icons.remove,
                            color: Theme.of(context).iconTheme.color),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: () => context.read<CardsCubit>().addRedCard(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Icon(Icons.add,
                            color: Theme.of(context).iconTheme.color),
                      ),
                    ),
                    Container(
                      width: kSpacingUnit.w * 6,
                      height: kSpacingUnit.w * 10,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).shadowColor,
                            offset: Offset(0, 5),
                            blurRadius: 3.0,
                          )
                        ],
                      ),
                      child: Builder(builder: (context) {
                        return Text(
                          context.watch<CardsCubit>().state.redCards.toString(),
                          style: TextStyle(fontSize: kSpacingUnit.w * 3),
                        );
                      }),
                    ),
                    TextButton(
                      onPressed: () =>
                          context.read<CardsCubit>().removeRedCard(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Icon(Icons.remove,
                            color: Theme.of(context).iconTheme.color),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
