import 'package:firstapp/pages/history_page.dart';
import 'package:firstapp/pages/mood_page.dart';
import 'package:firstapp/pages/videos_page.dart';
import 'package:flutter/material.dart';

import 'activities_page.dart';

class Home extends StatelessWidget {
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
            )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
                    child: Text('Tip text here',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                        textScaleFactor: 1.5)))
          ],
        ),
      ),
    );
  }
}
