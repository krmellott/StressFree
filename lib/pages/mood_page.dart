import '/utils/units_constant.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoodPage extends StatefulWidget {
  @override
  _MoodPage createState() => _MoodPage();
}

class _MoodPage extends State<MoodPage> {
  @override
  Moods currMood = Moods.Neutral;

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mood',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Builder(
            builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text("Moods"),
                ),
                body: Center(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Text(
                        "Mood",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                        textScaleFactor: 4,
                      ),
                    ),
                  ]),
                ))));
  }
}
