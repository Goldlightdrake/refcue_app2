import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class TestProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map> getQuestionFromFirebase(String documentId) async {
    Map mappedQuestion;
    await _firestore
        .collection('questions')
        .doc(documentId)
        .get()
        .then((DocumentSnapshot snapshot) => mappedQuestion = snapshot.data());
    return mappedQuestion;
  }

  Future<int> getAmountOfQuestions() async {
    int amountOfQuestions;
    await _firestore.collection('questions').doc('number').get().then(
        (DocumentSnapshot snapshot) =>
            amountOfQuestions = snapshot.data()['questionCount']);

    return amountOfQuestions;
  }
}
