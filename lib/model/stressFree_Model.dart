//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class stressFree_Model {
  final databaseReference =
      FirebaseDatabase.instance.reference().child('activity');

  ///Inserts a given activity into the firebase database given
  ///a set of parameters.
  dbInsertActivity(String name, bool status, List date) {
    print("dbInsertActivity called on: " +
        name +
        ", " +
        status.toString() +
        ", " +
        date.toString() +
        "}");
    print("Date verification: " + verifyActivityDate(date).toString());
    if (verifyActivityDate(date)) {
      databaseReference.set({
        'title': name,
        'status': status,
        'date': [date[0], date[1], date[2]]
      });
      print("{ok:1}");
    }
  }

  ///Accepts a date from the user and verifies if it is a valid date
  ///returns true if valid date, false if not
  verifyActivityDate(List date) {
    return (date[0] >= 1 && date[0] <= 12) &&
        (date[1] >= 1 && date[0] <= 31) &&
        (date[2] >= 1900);
  }
}
