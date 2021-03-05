import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refcue_app/data/repositories/test_repo.dart';
import 'package:refcue_app/firebase_login/authentication/bloc/authentication_bloc.dart';
import 'package:refcue_app/logic/exam_logic/bloc_timer/ticker.dart';
import 'package:refcue_app/logic/exam_logic/exam_logic.dart';
import 'package:refcue_app/shared/error_screen.dart';
import 'package:refcue_app/ui/screens/exam/view/exam_finished.dart';

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
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

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
          userId: user.id,
        )..add(ExamFetched()),
        child: BlocProvider(
          create: (context) => TimerBloc(ticker: Ticker()),
          child: BlocListener<ExamQuestionIndexCubit, int>(
            listener: (context, state) {
              if (state > amount - 1) {
                context.read<ExamBloc>().add(ExamFinishedEvent());
              }
            },
            child: BlocConsumer<ExamBloc, ExamState>(
              listener: (context, state) {
                if (state is ExamReady) {
                  context.read<TimerBloc>().add(
                      TimerStarted(duration: state.questionList.length * 60));
                }
              },
              builder: (context, state) {
                if (state is ExamError) {
                  return ErrorScreen();
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
      ),
    );
  }
}
