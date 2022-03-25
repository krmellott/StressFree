//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/units_constant.dart';

class stressFree_Model {
  final firestoreInstance = FirebaseFirestore.instance;
  //final databaseReference = FirebaseDatabase.instance.reference();

  ///Inserts a given activity into the firebase database given
  ///a set of parameters.
  dbInsertActivity(String name, bool status, List date, int priority) {
    // if (verifyActivityDate(date)) {
    //   databaseReference.child('activity').set({
    //     'title': name,
    //     'status': status,
    //     'priority': priority,
    //     'date': [date[0], date[1], date[2]]
    //   });
    //   print("{ok:1}");
    // } else {
    //   print("{ok:0} => An error occurred!");
    // }
  }

  /// Inserts into the database a list of parameters into the 'mood' collection in
  /// the database.
  dbInsertMood(Moods mood, List date) {
    // if (verifyActivityDate(date)) {
    //   databaseReference.child('moods').set({
    //     'mood': mood.toString(),
    //     'date': [date[0], date[1], date[2]]
    //   });
    //   print("{ok:1}");
    // } else {
    //   print("{ok:0} => An error occurred!");
    // }
  }

  /// Returns a snapshot of the 'activity' collection from the database
  dbRetrieveActivities() async {
    // DataSnapshot snapshot = await databaseReference.child('activity').get();
    // //Query query = databaseReference.child('activity').equalTo({"date": []});
    // if (snapshot.exists) {
    //   print("snapshot successful:" + snapshot.value.toString());
    // } else {
    //   print("snapshot does not exist!");
    // }

    firestoreInstance.collection("activity").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });

    // return snapshot;
  }

  dbRetrieveActivitiesByDate(DateTime date) async {
    // Query query = databaseReference.child('activity').equalTo({
    //   "date": [date.month, date.day, date.year]
    // });

    // return query;
  }

  dbRetrieveActivitiesSortedByPriority() {
    // Query query = databaseReference.child('activity').orderByChild("priority");
    // return query;
  }

  dbRetrieveActivitiesByCompletion(bool completion) async {
    // Query query =
    //     databaseReference.child('activity').equalTo({"status": completion});
    // return query;
  }

  /// Returns a snapshot of the 'mood; collection from the database
  dbRetrieveMoods() async {
    // var snapshot = await databaseReference.child('moods').get();
    // if (snapshot.exists) {
    //   print("snapshot successful:" + snapshot.value.toString());
    // } else {
    //   print("snapshot does not exist!");
    // }
    // return snapshot;
  }

  ///Accepts a date from the user and verifies if it is a valid date
  ///returns true if valid date, false if not
  verifyActivityDate(List date) {
    return (date[0] >= 1 && date[0] <= 12) &&
        (date[1] >= 1 && date[0] <= 31) &&
        (date[2] >= 1900);
  }
}
