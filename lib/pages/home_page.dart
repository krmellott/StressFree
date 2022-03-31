import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/pages/history_page.dart';
import 'package:firstapp/pages/mood_page.dart';
import 'package:firstapp/pages/videos_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'activities_page.dart';

class Home extends StatelessWidget {

  int tipID() {
    Random random = new Random();
    return random.nextInt(9) + 1;
  }

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StressFree!"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text(
                    "StressFree!",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                    textScaleFactor: 4,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: Text('Edit Activities'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ActivitiesPage();
                    }));
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: Text('Enter and View Daily Mood'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MoodPage();
                    }));
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: Text('View Activity Calendar and History'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return HistoryPage();
                    }));
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: Text('View Videos from YouTube'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return VideoPage();
                    }));
                  },
                ),
              ],
            )
            ),

            StreamBuilder (
                stream: FirebaseFirestore.instance.collection('tips').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 40.0, left: 20.0, right: 20.0),
                          child: Text('Tip: ' + snapshot.data?.docs[tipID()]['tip'], style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                              textScaleFactor: 1.5)
                      )
                  );
                }
            )
          ],
        ),
      )
    );
  }
}
