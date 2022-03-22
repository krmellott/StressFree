//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class stressFree_Model {
  final databaseReference =
      FirebaseDatabase.instance.reference().child('activity');

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
      print("date was verified!");
      databaseReference.set({
        'title': name,
        'status': status,
        'date': [date[0], date[1], date[2]]
      });
    }
  }

  dbRetrieveActivities() async {
    var snapshot = await databaseReference.get();
    if (snapshot.exists) {
      print("snapshot successful:" + snapshot.value.toString());
    } else {
      print("snapshot does not exist!");
    }
    return snapshot;
  }

  verifyActivityDate(List date) {
    return (date[0] >= 1 && date[0] <= 12) &&
        (date[1] >= 1 && date[0] <= 31) &&
        (date[2] >= 1900);
  }
}
