import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/units_constant.dart';

class StressFreeModel {
  final firestoreInstance = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid.toString();

  ///Inserts a given activity into the firebase database given
  ///a set of parameters.
  Future dbInsertActivity(
      String name, bool status, List date, int priority) async {
    if (verifyActivityDate(date)) {
      return await firestoreInstance.collection('activity').add({
        'title': '$name',
        'status': status,
        'date': [date[0], date[1], date[2]],
        'priority': '$priority',
        'userId': '$_uid'
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
          .where('userId', isEqualTo: _uid)
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
          'date': [date[0], date[1], date[2]],
          'userId': '$_uid'
        });
      }
    } else {
      print("{ok:0} => An error occurred!");
    }
  }

  dbInsertJournal(String body, int date, String title, String userID) async {
    return await firestoreInstance
        .collection('journal')
        .doc(date.toString())
        .set({'title': title, 'body': body, 'date': date, 'userId': '$_uid'});
  }

  dbRemoveJournal(String collection, String title, String userID) async {
    return await firestoreInstance
        .collection(collection)
        .doc(title)
        .delete();
  }

  /// Returns a snapshot of the 'activity' collection from the database
  Stream<QuerySnapshot> dbRetrieveActivities() {
    return firestoreInstance
        .collection("activity")
        .where('userId', isEqualTo: _uid)
        .snapshots();
  }

  Stream<QuerySnapshot> orderedActivities(
      String collection, String orderPreference) {
    firestoreInstance
        .collection("activity")
        .where('userId', isEqualTo: _uid)
        .snapshots()
        .forEach((element) {
      element.docs.forEach((doc) {
        print("Doc: " + doc.data().toString());
      });
    });
    return firestoreInstance
        .collection(collection)
        .orderBy(orderPreference)
        .where('userId', isEqualTo: _uid)
        .snapshots();
  }

  Stream<QuerySnapshot> orderedActivitiesWithSort(
      String collection, String orderPreference, bool sort) {
    firestoreInstance
        .collection("activity")
        .where('userId', isEqualTo: _uid)
        .snapshots()
        .forEach((element) {
      element.docs.forEach((doc) {
        print("Doc: " + doc.data().toString());
      });
    });
    return firestoreInstance
        .collection(collection)
        .orderBy(orderPreference, descending: sort)
        .where('userId', isEqualTo: _uid)
        .snapshots();
  }

  Stream<QuerySnapshot> retrieveCompletedActivities() {
    // print("\nRetrieve Completed Activities");
    // firestoreInstance
    //     .collection("activity")
    //     .orderBy('date')
    //     .where('userId', isEqualTo: _uid)
    //     .where('status', isEqualTo: true)
    //     .snapshots()
    //     .forEach((element) {
    //   element.docs.forEach((doc) {
    //     print("Doc: " + doc.data().toString());
    //   });
    // });
    return firestoreInstance
        .collection('activity')
        .orderBy('date')
        .where('status', isEqualTo: true)
        .where('userId', isEqualTo: _uid)
        .snapshots();
  }

  dbUpdateActivityCompletion(String activityName, bool isComplete) async {
    var activityInstance = await firestoreInstance
        .collection('activity')
        .where('userId', isEqualTo: _uid)
        .where('title', isEqualTo: activityName)
        .limit(1)
        .get();
    var docID = activityInstance.docs.first.id;
    DateTime currentDate = DateTime.now();
    try {
      firestoreInstance.collection('activity').doc(docID).update({
        'status': isComplete,
        'completionDate': [currentDate.month, currentDate.day, currentDate.year]
      });
    } catch (error) {
      print("{ok:0}");
      return;
    }
    print("{ok:1}");
    return;
  }

  dbUpdateActivity(String initialName, String newName, bool status, List date,
      int priority) async {
    var activityInstance = await firestoreInstance
        .collection('activity')
        .where('userId', isEqualTo: _uid)
        .where('title', isEqualTo: initialName)
        .limit(1)
        .get();
    var docID = activityInstance.docs.first.id;
    try {
      firestoreInstance.collection('activity').doc(docID).update({
        'title': '$newName',
        'status': status,
        'date': [date[0], date[1], date[2]],
        'priority': '$priority'
      });
    } catch (error) {
      print("{ok:0}");
      return;
    }
    print("{ok:1}");
    return;
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

  dbDeleteActivity(String activityName) async {
    var activityInstance = await firestoreInstance
        .collection('activity')
        .where('userId', isEqualTo: _uid)
        .where('title', isEqualTo: activityName)
        .limit(1)
        .get();

    var docID = activityInstance.docs.first.id;

    firestoreInstance.collection('activity').doc(docID).delete();
    print('Deleted ' + activityName);
    return;
  }

  getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    return uid.toString();
  }
}
