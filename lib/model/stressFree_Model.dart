import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../utils/units_constant.dart';

class stressFree_Model {
  final firestoreInstance = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid.toString();
  //final databaseReference = FirebaseDatabase.instance.reference();

  ///Inserts a given activity into the firebase database given
  ///a set of parameters.
  Future dbInsertActivity(
      String name, bool status, List date, int priority) async {
    String uid = await getCurrentUser();
    if (verifyActivityDate(date)) {
      return await firestoreInstance.collection('activity').add({
        'title': '$name',
        'status': '$status',
        'date': [date[0], date[1], date[2]],
        'priority': '$priority',
        'userId': '$uid'
      });
    } else {
      print("{ok:0} => An error occurred!");
    }
  }

  Future dbInsertVideo(bool isFavorite, String name, String url) async {
    return await firestoreInstance
        .collection('favorite videos')
        .doc(name)
        .set({'isFavorite': isFavorite, 'name': name, 'url': url});
  }

  Future dbRemoveVideo(String collection, String name) async {
    return await firestoreInstance
        .collection('favorite videos')
        .doc(name)
        .delete();
  }

  /// Inserts into the database a list of parameters into the 'mood' collection in
  /// the database.
  dbInsertMood(Moods mood, List date) async {
    if (verifyActivityDate(date)) {
      var recentAddition = await firestoreInstance
          .collection('moods')
          .orderBy("date", descending: true)
          .limit(1)
          .get();
      String compareDate = date.toString();
      if (compareDate.compareTo(recentAddition.docs[0]['date'].toString()) ==
          0) {
        var docID = recentAddition.docs.first.id;
        return firestoreInstance
            .collection('moods')
            .doc(docID.toString())
            .update({'mood': mood.toString()});
      } else {
        return await firestoreInstance.collection('moods').add({
          'mood': mood.toString(),
          'date': [date[0], date[1], date[2]]
        });
      }
    } else {
      print("{ok:0} => An error occurred!");
    }
  }

  dbInsertJournal(String body, List date, String title) async {
    if (verifyActivityDate(date)) {
      return await firestoreInstance.collection('journal').add({
        'title': title,
        'body': body,
        'date': [date[0], date[1], date[2]],
      });
    } else {
      print("{ok:0} => An error occurred!");
    }
  }

  /// Returns a snapshot of the 'activity' collection from the database
  dbRetrieveActivities(String userId) async {
    Queue queryQueue = new Queue();
    firestoreInstance
        .collection("activity")
        .where('userId', isEqualTo: userId)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        queryQueue.add(result);
      });
    });
    return queryQueue;
  }

  Stream<QuerySnapshot> orderedActivities(
      String collection, String orderPreference, String currUid) {
    print('userID: ' + currUid);
    firestoreInstance
        .collection("activity")
        .where('userId', isEqualTo: currUid)
        .snapshots()
        .forEach((element) {
      element.docs.forEach((doc) {
        print("Doc: " + doc.data().toString());
      });
    });
    return firestoreInstance
        .collection(collection)
        .orderBy(orderPreference)
        .where('userId', isEqualTo: currUid)
        .snapshots();
  }

  Stream<QuerySnapshot> orderedActivitiesWithSort(
      String collection, String orderPreference, bool sort, String currUid) {
    print('userID: ' + currUid);
    firestoreInstance
        .collection("activity")
        .where('userId', isEqualTo: currUid)
        .snapshots()
        .forEach((element) {
      element.docs.forEach((doc) {
        print("Doc: " + doc.data().toString());
      });
    });
    return firestoreInstance
        .collection(collection)
        .orderBy(orderPreference, descending: sort)
        .where('userId', isEqualTo: currUid)
        .snapshots();
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
    bool isDate = (date[0] >= 1 && date[0] <= 12) &&
        (date[1] >= 1 && date[0] <= 31) &&
        (date[2] >= 1900);
    print("The date is: " +
        date[0].toString() +
        "/" +
        date[1].toString() +
        "/" +
        date[2].toString() +
        " is " +
        isDate.toString());
    return isDate;
  }

  getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    return uid.toString();
  }
}
