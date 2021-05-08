import 'package:cloud_firestore/cloud_firestore.dart';

class UserStatsRepository {
  UserStatsRepository({required this.userId});

  final String? userId;
  CollectionReference usersStatsCollection =
      FirebaseFirestore.instance.collection('users_stats');

  void addUserToStatsDatabase() {
    usersStatsCollection
        .doc(userId)
        .set({
          'questionsPassed': 0,
          'sumScore': {
            'five': 0,
            'ten': 0,
            'thirty': 0,
          },
          'examPassed': {
            'five': 0,
            'ten': 0,
            'thirty': 0,
          },
        })
        .then((value) => print('User stats created'))
        .catchError((error) => print("Didn't create user's stats"));
  }

  void afterExamIncreament(double score, int? typeOfExam) {
    String? keyForExam;
    switch (typeOfExam) {
      case 5:
        keyForExam = 'five';
        break;
      case 10:
        keyForExam = 'ten';
        break;
      case 30:
        keyForExam = 'thirty';
        break;
      default:
    }

    usersStatsCollection
        .doc(userId)
        .set({
          'lastExam': FieldValue.serverTimestamp(),
          'sumScore': {
            keyForExam: FieldValue.increment(score),
          },
          'examPassed': {
            keyForExam: FieldValue.increment(1),
          },
          'questionsPassed': FieldValue.increment(typeOfExam!),
        }, SetOptions(merge: true))
        .then((value) => print('User stats updated'))
        .catchError((error) => throw (error));
  }
}
