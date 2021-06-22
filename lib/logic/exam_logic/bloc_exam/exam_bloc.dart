import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:refcue_app/data/models/question.dart';
import 'package:refcue_app/data/repositories/exam_repo.dart';
import 'package:refcue_app/data/repositories/user_stats_repo.dart';
import 'package:refcue_app/logic/custom_exam_logic/cubit/user_choice_cubit.dart';
import 'package:refcue_app/logic/exam_logic/cubit_answer/answer_cubit.dart';
import 'package:refcue_app/logic/exam_logic/cubit_var/exam_var_cubit.dart';

part 'exam_event.dart';
part 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final ExamRepository? examRepository;
  final ExamScoreCubit? scoreCubit;
  final ExamQuestionIndexCubit? indexCubit;
  final AnswerCubit? answerCubit;
  final int? maxIndex;
  final String? userId;
  final UserChoiceCubit? userChoiceCubit;
  ExamBloc(
      {this.examRepository,
      this.scoreCubit,
      this.indexCubit,
      this.answerCubit,
      this.maxIndex,
      this.userId,
      this.userChoiceCubit})
      : super(ExamLoading());

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
      UserStatsRepository(userId: userId)
          .afterExamIncreament(scoreCubit!.state, maxIndex);
      yield ExamFinished(
          userAnswers: answerCubit!.userAnswersList,
          userScore: scoreCubit!.state,
          examMaxScore: maxIndex,
          questionsList: (state as ExamReady).questionList);
    }
  }

  Future<List<Question>> _getQuestions() async {
    try {
      final List<Question> questionsList =
          await examRepository!.listOfQuestions();

      return questionsList;
    } catch (_) {
      throw Exception('error getting questions from repo');
    }
  }

  Future<List<Question>> _getCustomQuestions() async {
    try {
      final List<Question> questionsList =
          await (examRepository!.listOfQuestions() as FutureOr<List<Question>>);
      return questionsList;
    } catch (_) {
      throw Exception('error getting questions from repo');
    }
  }
}
