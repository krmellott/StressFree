import '/utils/units_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/pages//chart/line_chart.dart';
import 'package:firstapp/pages//chart_container.dart';

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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green
                      ),
                      child: Text('Show/Hide Graph'),
                      onPressed: () {

                      },
                    ),
                    ChartContainer(
                          title: 'Mood Graph',
                          color: Colors.green,
                          chart: LineChartContent(),
                    ),
                  ]),
                ))));
  }
}
