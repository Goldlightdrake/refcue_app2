import 'dart:async';

import 'package:refcue_app/shared/functions.dart';

import '../data_provider/exam_provider.dart';
import '../models/question.dart';

class ExamRepository {
  final int amountOfQuestions;
  ExamRepository({
    required this.amountOfQuestions,
  });

  ExamProvider _examProvider = ExamProvider();

  Future<List<Question>> listOfQuestions() async {
    List questionsIdList = randNumbersInRange(
        amountOfQuestions, (await _examProvider.getAmountOfQuestions())!);

    List<Question> listOfQuestions = [];
    for (int i = 0; i < amountOfQuestions; i++) {
      listOfQuestions.add(Question.fromMap(
          (await _examProvider.getQuestionFromFirebase(questionsIdList[i]))));
    }
    return listOfQuestions;
  }

  Future customListOfQuestion(List<String> articles) async {
    List<Question> listOfQuestions = [];
    List<int> listOfIndexesInUse = [];

    for (int i = 0; i < amountOfQuestions; i++) {
      int questionId = randNumberInRange(
          (await _examProvider.getAmountOfQuestions())!, listOfIndexesInUse);
      Map<dynamic, dynamic> questionMap = await _examProvider
          .getCustomQuestionFromFirebase(questionId, articles);
      Question question = Question.fromMap(questionMap);
      listOfQuestions.add(question);
      listOfIndexesInUse.add(question.id);
    }
  }
}
