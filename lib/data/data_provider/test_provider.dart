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
}
