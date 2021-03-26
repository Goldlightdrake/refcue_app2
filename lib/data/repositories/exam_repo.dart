import 'dart:async';

import 'package:refcue_app/shared/functions.dart';

import '../data_provider/exam_provider.dart';
import '../models/question.dart';

class ExamRepository {
  final int? amountOfQuestions;
  ExamRepository({
    required this.amountOfQuestions,
  });

  ExamProvider _examProvider = ExamProvider();

  Future listOfQuestions() async {
    List range = numberInRange(
        amountOfQuestions, (await (_examProvider.getAmountOfQuestions()))!);
    List<Question> listOfQuestions = [];
    // for (int i = 1; i <= amountOfQuestions!; i++) {
    //   listOfQuestions.add(Question.fromMap((await (_examProvider
    //       .getQuestionFromFirebase(range[i - 1].toString())))!));
    // }
    return listOfQuestions;
  }
}
