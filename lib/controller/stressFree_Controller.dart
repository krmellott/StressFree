import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/utils/units_constant.dart';

import '../model/StressFreeModel.dart';

class StressFreeController {
  final modelReference = new StressFreeModel();
  final String _userID = FirebaseAuth.instance.currentUser!.uid;

  /// inserts: {'name':<string>, 'status':<bool>, 'date':{'month':<int>,'day':<int>,'year':<int>}}
  insertActivityData(String name, bool status, List date, int priority) {
    print("ctrllr.insertActivityData{" +
        name +
        ", " +
        status.toString() +
        ", " +
        date[0].toString() +
        date[1].toString() +
        date[2].toString() +
        "}");
    modelReference.dbInsertActivity(name, status, date, priority);
  }

  /// inserts: {'mood':<String>, 'date':{'month':<int>,'day':<int>,'year':<int>}}
  insertMoodData(Moods mood, List date) {
    modelReference.dbInsertMood(mood, date);
  }

  insertVideo(String title, bool isFavorite, String url) {
    modelReference.dbInsertVideo(isFavorite, title, url);
  }

  removeVideo(String collection, String title) {
    modelReference.dbRemoveVideo(collection, title);
  }

  insertJournalData(String title, int date, String body) {
    modelReference.dbInsertJournal(title, date, body, _userID);
  }

  updateActivityCompletion(String title, bool isComplete) {
    modelReference.dbUpdateActivityCompletion(title, isComplete);
  }

  updateActivity(String initialName, String newName, bool status, List date,
      int priority) {
    modelReference.dbUpdateActivity(
        initialName, newName, status, date, priority);
  }

  deleteActivity(String title) {
    modelReference.dbDeleteActivity(title);
  }
}
