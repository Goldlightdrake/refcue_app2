import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class UserStatsRepository {
  UserStatsRepository({@required this.userId});

  final String userId;
  CollectionReference usersStatsCollection =
      FirebaseFirestore.instance.collection('users_stats');

  void addUserToStatsDatabase() {
    usersStatsCollection
        .doc(userId)
        .set({
          'createdOn': Timestamp.now(),
          'questionsPassed': 0,
          'sumScore': {
            5: 0,
            10: 0,
            30: 0,
          },
          'examPassed': {
            5: 0,
            10: 0,
            30: 0,
          },
          'examTime': {
            5: 0,
            10: 0,
            30: 0,
          }
        }) //SetOptions(merge : true)
        .then((value) => print('User stats created'))
        .catchError((error) => print("Didn't create user's stats"));
  }

  // void afterExamIncreament() {
  //   usersStatsCollection.doc(userId).set(, SetOptions(merge: true));
  // }
}
