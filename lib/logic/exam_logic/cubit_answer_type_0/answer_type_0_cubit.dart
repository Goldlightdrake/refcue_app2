import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_login/logic/exam_logic/cubit_answer/answer_cubit.dart';

part 'answer_type_0_state.dart';

class AnswerType0Cubit extends Cubit<AnswerType0State> {
  final AnswerCubit answerCubit;
  AnswerType0Cubit(
    this.answerCubit,
  ) : super(AnswerType0());

  void goToCards() {
    emit(AnswerType0Cards());
  }

  void goBack() {
    emit(AnswerType0());
  }
}
