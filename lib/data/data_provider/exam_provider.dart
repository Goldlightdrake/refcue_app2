import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class ExamProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<dynamic, dynamic>> getQuestionFromFirebase(int questionId) async {
    Map<dynamic, dynamic> mappedQuestion = Map();

    await _firestore
        .collection('questions')
        .where('id', isEqualTo: questionId)
        .limit(1)
        .get()
        .then((questionData) => mappedQuestion = questionData.docs[0].data());
    return mappedQuestion;
  }

  Future<Map<dynamic, dynamic>> getCustomQuestionFromFirebase(
      int questionId, List<String> articles) async {
    Map<dynamic, dynamic> mappedQuestion = Map();

    await _firestore
        .collection('questions')
        //.startAt()
        .where('article', arrayContainsAny: articles)
        .limit(1)
        .get()
        .then((questionData) => mappedQuestion = questionData.docs[0].data());
    print(mappedQuestion);
    return mappedQuestion;
  }

  Future<int?> getAmountOfQuestions() async {
    int? amountOfQuestions;
    await _firestore
        .collection('questions')
        .doc('amount_of_questions')
        .get()
        .then((DocumentSnapshot snapshot) =>
            amountOfQuestions = snapshot['amount']!);

    return amountOfQuestions;
  }
}
