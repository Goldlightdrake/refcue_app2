import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_login/data/models/question.dart';
import 'package:flutter_firebase_login/data/repositories/test_repo.dart';
import 'package:meta/meta.dart';

part 'exam_event.dart';
part 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final TestRepository testRepository;
  ExamBloc({@required this.testRepository}) : super(ExamLoading());

  @override
  Stream<ExamState> mapEventToState(
    ExamEvent event,
  ) async* {
    if (event is ExamFetched) {
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
}
