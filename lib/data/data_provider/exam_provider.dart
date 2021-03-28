import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class ExamProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map?> getQuestionFromFirebase(String articleIndex, int questionIndex,
      List<int>? duplicatedIndex) async {
    Map? mappedQuestion;

    await _firestore
        .collection('questions')
        .doc(articleIndex)
        .collection('questions_' + articleIndex)
        .where('id',
            isGreaterThanOrEqualTo: questionIndex, whereNotIn: duplicatedIndex)
        .limit(1)
        .get()
        .then((questionData) => mappedQuestion = questionData.docs[0].data());
    print(mappedQuestion);
    return mappedQuestion;
  }

  Future<int?> getAmountOfQuestions() async {
    int? amountOfQuestions;
    await _firestore.collection('questions').doc('number').get().then(
        (DocumentSnapshot snapshot) =>
            amountOfQuestions = snapshot.data()!['questionCount']);

    return amountOfQuestions;
  }
}
