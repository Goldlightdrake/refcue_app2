import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:refcue_app/data/models/question.dart';

part 'building_question_layout_state.dart';

class BuildingQuestionLayoutCubit extends Cubit<BuildingQuestionLayoutState> {
  BuildingQuestionLayoutCubit() : super(BuildingQuestionLayoutLoading());

  void buildQuestionLayout(Question question) {
    emit(BuildingQuestionLayoutLoading());
    try {
      emit(QuestionLayoutBuilt(question: question));
    } catch (_) {
      emit(QuestionLayoutError());
    }
  }
}
