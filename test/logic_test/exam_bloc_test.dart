import 'package:flutter_test/flutter_test.dart';
import 'package:refcue_app/data/repositories/exam_repo.dart';

void main() {
  group('ExamBlocTest -', () {
    group('setting up exam', () {
      test('When called exam_repository should return questions list', () {
        var repo = ExamRepository(amountOfQuestions: 5);
      });
    });
  });
}
