import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/data/repositories/test_repo.dart';
import 'package:flutter_firebase_login/logic/bloc.dart';
import 'package:flutter_firebase_login/logic/cubit_answer/answer_cubit.dart';
import 'package:flutter_firebase_login/logic/cubit_var/exam_var_cubit.dart';
import 'package:flutter_firebase_login/ui/screens/exam/view/exam_finished.dart';

import 'exam_view.dart';

class ExamScreen extends StatelessWidget {
  static Route route({int amountQuestions}) {
    return MaterialPageRoute<void>(
        builder: (_) => ExamScreen(
              amount: amountQuestions,
            ));
  }

  final int amount;
  ExamScreen({Key key, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> userAnswersList = [for (var i = 0; i < amount; i++) '-'];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExamQuestionIndexCubit(),
        ),
        BlocProvider(
          create: (context) => ExamScoreCubit(),
        ),
        BlocProvider(
          create: (context) => AnswerCubit(
            userAnswersList: userAnswersList,
            scoreCubit: context.read<ExamScoreCubit>(),
          ),
        )
      ],
      child: BlocProvider(
        create: (context) => ExamBloc(
          testRepository: TestRepository(amountOfQuestions: amount),
          scoreCubit: context.read<ExamScoreCubit>(),
          indexCubit: context.read<ExamQuestionIndexCubit>(),
          answerCubit: context.read<AnswerCubit>(),
          maxIndex: amount,
        )..add(ExamFetched()),
        child: BlocListener<ExamQuestionIndexCubit, int>(
          listener: (context, state) {
            if (state > amount - 1) {
              context.read<ExamBloc>().add(ExamFinishedEvent());
            }
          },
          child: BlocBuilder<ExamBloc, ExamState>(
            builder: (context, state) {
              if (state is ExamError) {
                return Center(
                    child: Column(
                  children: [
                    Icon(Icons.error),
                    Text('Coś poszło nie tak :/ Spróbuj zrestarować aplikacje')
                  ],
                ));
              }
              if (state is ExamReady) {
                return ExamViewScreen(
                  listOfQuestions: state.questionList,
                );
              }
              if (state is ExamFinished) {
                return FinishedExamScreen();
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
