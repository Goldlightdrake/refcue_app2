import 'package:flutter_firebase_login/shared/functions.dart';
import 'package:meta/meta.dart';

import '../data_provider/test_provider.dart';
import '../models/question.dart';

class TestRepository {
  final int amountOfQuestions;
  TestRepository({
    @required this.amountOfQuestions,
  });

  TestProvider _testProvider = TestProvider();

  Future listOfQuestions() async {
    List<int> range = numberInRange(
        amountOfQuestions, await _testProvider.getAmountOfQuestions());
    List<Question> listOfQuestions = [];
    for (int i = 1; i <= amountOfQuestions; i++) {
      listOfQuestions.add(Question.fromMap(await _testProvider
          .getQuestionFromFirebase(range[i - 1].toString())));
    }
    return listOfQuestions;
  }
}
