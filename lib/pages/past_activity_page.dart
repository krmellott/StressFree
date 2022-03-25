//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/model/stressFree_Model.dart';

class PastActivities extends StatefulWidget {
  @override
  _PastActivities createState() => _PastActivities();
}

class _PastActivities extends State<PastActivities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Completed Activities'),
        ),
        body: Center(
            child: Column(
          children: [Text('Activity history here.'), printTasks()],
        )));
  }

  printTasks() {
    stressFree_Model model = new stressFree_Model();
    //Query query = model.dbRetrieveActivitiesByCompletion(true);
    //print(query.toString());
  }
}
