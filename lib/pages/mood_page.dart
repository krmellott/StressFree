import 'package:firstapp/utils/units_constant.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:firstapp/controller/stressFree_Controller.dart';
import 'package:firstapp/model/stressFree_Model.dart';
import '/utils/units_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoodPage extends StatefulWidget {
  @override
  _MoodPage createState() => _MoodPage();
}

class _MoodPage extends State<MoodPage> {
  bool isVisible = false;
  Color color = Colors.grey;
  @override
  Moods currMood = Moods.Neutral;
  final controllerReference = new stressFree_Controller();
  final modelReference = new stressFree_Model();
  List<ChartData> testList = <ChartData>[];




  Widget build(BuildContext context) {
 /*   for (int i = 1; i < 5; i++) {
      String testDate = i.toString() + '/33/22';
      testList.add(ChartData(testDate, 2));
    } */
    return Scaffold(

      backgroundColor: color,
      appBar: AppBar(
        title: Text("Moods"),
      ),
        body: Center(
          child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text(
                    "Mood",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textScaleFactor: 4,
                  ),
                ),
                DropdownButton<Moods>(
                    hint: Text('Please choose a mood'),
                    value: currMood,
                    icon: const Icon(Icons.arrow_downward),
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    onChanged: (newMood) {
                      setState(() {
                        _MoodPage().currMood = newMood!;
                        currMood = newMood;
                        controllerReference.insertMoodData(currMood, [DateTime.now().month, DateTime.now().day, DateTime.now().year]);
                      switch(newMood) {
                      case Moods.Neutral: {
                        color = Colors.grey;
                        setState(() {
                        });
                      }
                      break;
                      case Moods.Angry: {
                        color = Colors.red;
                        setState(() {
                        });
                      }
                      break;
                      case Moods.Happy: {
                        color = Colors.amber;
                        setState(() {
                        });
                      }
                      break;
                      case Moods.Elated: {
                        color = Colors.purple;
                        setState(() {
                        });
                      }
                      break;
                      case Moods.Sad: {
                        color = Colors.blueAccent;
                        setState(() {
                        });
                      }
                      break;
                    }}
                      );
                    },
                    items: Moods.values.map((Moods mood) {
                      return DropdownMenuItem<Moods>(
                          value: mood,
                          child: Text(mood.toString().substring(6)));
                    }).toList()
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  child: Text(
                      'Show/Hide Graph',
                      style: const TextStyle(color: Colors.black)
                  ),
                  onPressed: () {
                    isVisible = !isVisible;
                    setState(() {

                    });
                    },
                ),
                Container(
                  width: 375,
                    height: 300,
                    child: Visibility(
                    visible: isVisible,
                    child: Row (
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column (
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 35, bottom: 41.5),
                              child: Text(
                                'Elated',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 41.5),
                              child: Text(
                                'Happy',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 41.5),
                              child: Text(
                                'Neutral',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 41.5),
                              child: Text(
                                'Sad',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              'Angry',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("moods").orderBy("date", descending: true).snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return Text('No past moods.');
                          else {
                            List<ChartData> dataSet = <ChartData>[];
                            for (int i = 1; i < 8; i++) {
                              String testDate = i.toString() + '/33/22';
                              if (i > 5) {testList.add((ChartData(testDate, (i - 4.0))));}
                              else
                              testList.add(ChartData(testDate, i.toDouble()));
                            }
                            
                            for (int i = 0; i < 7; i++) {
                            //snapshot.data?.docs.forEach((element) {
                              //var mood = element['mood'];
                              //var date = element['date'];
                              var mood = snapshot.data?.docs[i]['mood'];
                              var date = snapshot.data?.docs[i]['date'];
                              String dateString = date.toString();
                              String moodString = mood.toString();
                              double moodDouble = 3;
                              switch (moodString) {
                                case "Moods.Elated":
                                  moodDouble = 5;
                                  break;
                                case "Moods.Happy":
                                  moodDouble = 4;
                                  break;
                                case "Moods.Neutral":
                                  moodDouble = 3;
                                  break;
                                case "Moods.Sad":
                                  moodDouble = 2;
                                  break;
                                case "Moods.Angry":
                                  moodDouble = 1;
                              }
                              dataSet.add(ChartData(dateString, moodDouble));
                            } //);
                            return SfCartesianChart(
                                zoomPanBehavior: ZoomPanBehavior(
                                  enablePinching: true,
                                  zoomMode: ZoomMode.x,
                                  enablePanning: true,
                                ),
                                primaryXAxis: CategoryAxis(
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                title: ChartTitle(text: 'Mood Graph'),
                                primaryYAxis: NumericAxis(
                                  maximum: 5,
                                  minimum: 1,
                                  isVisible: false,
                                ),
                                series: <ChartSeries>[
                                  LineSeries<ChartData, String>(
                                      color: Colors.white,
                                      markerSettings: MarkerSettings(
                                        isVisible: true,
                                      ),
                                      dataSource: dataSet,
                                      xValueMapper: (ChartData data, _) =>
                                      data.x,
                                      yValueMapper: (ChartData data, _) =>
                                      data.y
                                  )
                                ]
                            );
                          }
                        }
                        ),
                        )
                      ],
                    )
                )
                )
              ]
          ),
        )
    );
  }
}
class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
