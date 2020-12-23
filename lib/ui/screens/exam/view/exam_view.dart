import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_firebase_login/data/models/question.dart';
import 'package:flutter_firebase_login/logic/cubit_question_layout/building_question_layout_cubit.dart';
import 'package:flutter_firebase_login/logic/cubit_var/exam_var_cubit.dart';
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
      child: BlocListener<ExamQuestionIndexCubit, int>(
        listenWhen: (previousState, state) {
          if (state != previousState) {
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
              return Center(
                child: Icon(Icons.error),
              );
            }
            return Center(
                child:
                    CircularProgressIndicator()); // TODO fajne ładowanie pytania(cos jak w spotify/netflix)
          },
        ),
      ),
    );
  }
}
