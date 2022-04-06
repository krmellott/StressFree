import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/pages/history_page.dart';
import 'package:firstapp/pages/mood_page.dart';
import 'package:firstapp/pages/videos_page.dart';
import 'package:firstapp/utils/add_videos.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'activities_page.dart';
import 'videos_page.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  int tipID() {
    Random random = new Random();
    return random.nextInt(9) + 1;
  }


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
                ),
                Row(
                  children:[
                ElevatedButton.icon(

                  icon: Icon(
                    Icons.directions_run_rounded,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                      minimumSize: Size(150, 150)),
                  label: Text('Activities'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ActivitiesPage();
                    }));
                    setState(() {

                    });
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.sentiment_satisfied_rounded,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                      minimumSize: Size(150, 150)),
                  label: Text('Mood'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MoodPage();
                    }));
                    setState(() {

                    });
                  },
                ),
                  ]),
                Row(
                  children: [
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.access_time_rounded,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                      minimumSize: Size(150, 150)),
                  label: Text('History'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return HistoryPage();
                    }));
                    setState(() {

                    });
                  },
                ),
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                      minimumSize: Size(150, 150)),
                  label: Text('Videos'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return VideosPage();
                    }));
                    setState(() {

                    });
                  },
                ),
                    ]),
              ],
            )
            ),
          ],
        ),
      )
    );
  }
}
