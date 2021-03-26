import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class ExamProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map?> getQuestionFromFirebase(
      String articleIndex, int questionIndex) async {
    Map? mappedQuestion;

    await _firestore
        .collection('questions')
        .doc(articleIndex)
        .collection('questions_' + articleIndex)
        .where('id', isLessThan: questionIndex)
        .limit(1)
        .get()
        .then((questionData) => print(questionData.docs[0].data()));
    // print(mappedQuestion!['answer']);
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
