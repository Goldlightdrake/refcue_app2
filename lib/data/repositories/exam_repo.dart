import 'dart:async';

import '../data_provider/exam_provider.dart';
import '../models/question.dart';

class ExamRepository {
  final int? amountOfQuestions;
  ExamRepository({
    required this.amountOfQuestions,
  });

  ExamProvider _examProvider = ExamProvider();

  Future listOfQuestions() async {
    // List<int> articlesList = numberInRange(amountOfQuestions, 17);
    List<int> articlesList = [1, 1, 12, 1, 1];
    List<int> indexesList = [0, 3, 2, 6, 1];
    print(articlesList);
    List<Question> listOfQuestions = [];
    List<int> duplicatedIndex = [-1];
    for (int i = 0; i < amountOfQuestions!; i++) {
      listOfQuestions.add(Question.fromMap(
          (await (_examProvider.getQuestionFromFirebase(
              articlesList[i].toString(), indexesList[i], duplicatedIndex)))!));
      duplicatedIndex.add(listOfQuestions[i].id);
    }
    return listOfQuestions;
  }
}
