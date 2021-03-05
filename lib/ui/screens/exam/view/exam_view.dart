import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:refcue_app/data/models/question.dart';
import 'package:refcue_app/logic/exam_logic/exam_logic.dart';
import 'package:refcue_app/shared/error_screen.dart';

import 'package:refcue_app/ui/screens/exam/widgets/question_layout.dart';

class ExamViewScreen extends StatelessWidget {
  final List<Question> listOfQuestions;
  const ExamViewScreen({
    Key key,
    this.listOfQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BuildingQuestionLayoutCubit()
          ..buildQuestionLayout(listOfQuestions[0]),
        child: BlocListener<TimerBloc, TimerState>(
          listener: (context, state) {
            if (state == TimerRunComplete()) {
              context.read<AnswerCubit>().checkUserAnswers((listOfQuestions));
              context.read<ExamBloc>().add(ExamFinishedEvent());
            }
          },
          child: BlocListener<ExamQuestionIndexCubit, int>(
            listenWhen: (previousState, state) {
              if (state != previousState &&
                  state != context.read<ExamBloc>().maxIndex) {
                return true;
              }
              return false;
            },
            listener: (context, state) {
              context
                  .read<BuildingQuestionLayoutCubit>()
                  .buildQuestionLayout(listOfQuestions[state]);
            },
            child: BlocBuilder<BuildingQuestionLayoutCubit,
                BuildingQuestionLayoutState>(
              builder: (context, state) {
                if (state is QuestionLayoutBuilt) {
                  return QuestionLayout(
                    question: state.question,
                  );
                }
                if (state is QuestionLayoutError) {
                  return ErrorScreen();
                }
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ); // TODO fajne ładowanie pytania(cos jak w spotify/netflix)
              },
            ),
          ),
        ));
  }
}
