import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../cubit_var/exam_var_cubit.dart';

part 'answer_state.dart';

class AnswerCubit extends Cubit<AnswerState> {
  final ExamScoreCubit scoreCubit;
  AnswerCubit({
    @required this.scoreCubit,
  }) : super(AnswerInitial());

  List<String> userAnswersList = [];

  void pickAnswer(int index) {
    emit(AnswerPicked(index: index));
  }

  void takeAnswer(String answer, String questionAnswer, int type) {
    userAnswersList.add(answer);
    scoreCubit.checkAnswer(answer, questionAnswer, type);
    emit(AnswerInitial());
  }
}
