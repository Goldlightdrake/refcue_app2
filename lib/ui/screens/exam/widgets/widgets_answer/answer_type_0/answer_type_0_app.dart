import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refcue_app/logic/exam_logic/exam_logic.dart';
import './answer_type_0.dart';
import './answer_type_0_card_view.dart';

class AnswerType0App extends StatelessWidget {
  const AnswerType0App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AnswerType0Cubit(context.read<AnswerCubit>()),
        child: BlocBuilder<AnswerType0Cubit, AnswerType0State>(
          builder: (context, state) {
            if (state is AnswerType0Cards) {
              return AnswerType0CardsView(
                key: UniqueKey(),
              );
            }
            return AnswerType0View(
              key: UniqueKey(),
            );
          },
        ));
  }
}
