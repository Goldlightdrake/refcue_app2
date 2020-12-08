import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/shared/functions.dart';

class TestProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getQuestionFromFirebase(String documentId) async {
    return await _firestore.collection('questions').doc(documentId).get();
  }

  Map questionMapFromFirebase(String documentId) {
    Map questionMapFromFirebase;
    getQuestionFromFirebase(documentId).then((DocumentSnapshot carSnapshot) => {
          questionMapFromFirebase = carSnapshot.data(),
        });
    return questionMapFromFirebase;
  }
}
