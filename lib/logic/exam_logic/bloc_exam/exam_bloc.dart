import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_firebase_login/data/models/question.dart';
import 'package:flutter_firebase_login/data/repositories/test_repo.dart';
import 'package:flutter_firebase_login/logic/exam_logic/cubit_answer/answer_cubit.dart';
import 'package:flutter_firebase_login/logic/exam_logic/cubit_var/exam_var_cubit.dart';

part 'exam_event.dart';
part 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final TestRepository testRepository;
  final ExamScoreCubit scoreCubit;
  final ExamQuestionIndexCubit indexCubit;
  final AnswerCubit answerCubit;
  final int maxIndex;
  ExamBloc({
    this.testRepository,
    this.scoreCubit,
    this.indexCubit,
    this.answerCubit,
    this.maxIndex,
  }) : super(ExamLoading());

  @override
  Stream<ExamState> mapEventToState(
    ExamEvent event,
  ) async* {
    if (event is ExamFetched) {
      yield ExamLoading();
      try {
        if (state is ExamLoading) {
          final questions = await _getQuestions();
          yield ExamReady(questionList: questions);
          return;
        }
      } catch (_) {
        yield ExamError();
      }
    }
    if (event is ExamCustomFetched) {
      try {
        if (state is ExamLoading) {
          final questions = await _getCustomQuestions();
          yield ExamReady(questionList: questions);
          return;
        }
      } catch (_) {
        yield ExamError();
      }
    }
    if (event is ExamFinishedEvent) {
      yield ExamFinished(
          userAnswers: answerCubit.userAnswersList,
          userScore: scoreCubit.state,
          examMaxScore: maxIndex,
          questionsList: (state as ExamReady).questionList);
    }
  }

  Future<List<Question>> _getQuestions() async {
    try {
      final List<Question> questionsList =
          await testRepository.listOfQuestions();
      return questionsList;
    } catch (_) {
      throw Exception('error getting questions from repo');
    }
  }

  Future<List<Question>> _getCustomQuestions() async {
    try {
      final List<Question> questionsList =
          await testRepository.listOfQuestions();
      return questionsList;
    } catch (_) {
      throw Exception('error getting questions from repo');
    }
  }
}
