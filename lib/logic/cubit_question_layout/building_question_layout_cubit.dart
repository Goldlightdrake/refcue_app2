import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_firebase_login/data/models/question.dart';
import 'package:flutter_firebase_login/logic/cubit_var/exam_var_cubit.dart';

part 'building_question_layout_state.dart';

class BuildingQuestionLayoutCubit extends Cubit<BuildingQuestionLayoutState> {
  BuildingQuestionLayoutCubit() : super(BuildingQuestionLayoutLoading());

  void buildQuestionLayout(Question question) {
    try {
      emit(QuestionLayoutBuilt(question: question));
    } catch (_) {
      emit(QuestionLayoutError());
    }
  }
}
