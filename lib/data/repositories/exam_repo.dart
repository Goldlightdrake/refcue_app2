import 'dart:async';

import 'package:refcue_app/shared/functions.dart';

import '../data_provider/exam_provider.dart';
import '../models/question.dart';

class ExamRepository {
  final int? amountOfQuestions;
  ExamRepository({
    required this.amountOfQuestions,
  });

  TestProvider _testProvider = TestProvider();

  Future listOfQuestions() async {
    List<int?> range = numberInRange(
            amountOfQuestions, (await (_testProvider.getAmountOfQuestions()))!)
        as List<int?>;
    List<Question> listOfQuestions = [];
    for (int i = 1; i <= amountOfQuestions!; i++) {
      listOfQuestions.add(Question.fromMap((await (_testProvider
          .getQuestionFromFirebase(range[i - 1].toString())))!));
    }
    return listOfQuestions;
  }
}
