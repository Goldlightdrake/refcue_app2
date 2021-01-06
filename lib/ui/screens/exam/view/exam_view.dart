import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_firebase_login/data/models/question.dart';
import 'package:flutter_firebase_login/logic/exam_logic/exam_logic.dart';

import 'package:flutter_firebase_login/ui/screens/exam/widgets/question_layout.dart';

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
                  return Row(children: [
                    Text(
                      "Coś poszło nie tak! Spróbuj zresetować aplikacje",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Icon(Icons.error, size: 32),
                  ], mainAxisAlignment: MainAxisAlignment.center);
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
