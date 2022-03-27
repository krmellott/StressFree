import 'package:firstapp/utils/Activity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ActivityList extends StatefulWidget {
  const ActivityList({Key? key}) : super(key: key);

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<List<Activity>>(context);

    activities.forEach((activity) {
      print("Activity{" +
          activity.title +
          ", " +
          activity.priority +
          ", " +
          activity.status.toString() +
          ", " +
          activity.date[0] +
          activity.date[1] +
          activity.date[2] +
          "}");
    });

    return Container();
  }
}
