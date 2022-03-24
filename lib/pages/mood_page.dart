import 'package:firstapp/utils/units_constant.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:firstapp/controller/stressFree_Controller.dart';
import 'package:firstapp/model/stressFree_Model.dart';
import '/utils/units_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:firstapp/pages//chart/line_chart.dart';
//import 'package:firstapp/pages//chart_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

  Widget build(BuildContext context) {

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
                Visibility(
                  /*child: ChartContainer(
                    title: 'Mood Graph',
                    color: Colors.white,
                    chart: LineChartContent(),
                  ),*/
                  child: SfCartesianChart(
                    // Initialize category axis
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        // Initialize line series
                        LineSeries<ChartData, String>(
                            dataSource: [
                              // Bind data source
                              ChartData('Jan', 35),
                              ChartData('Feb', 28),
                              ChartData('Mar', 34),
                              ChartData('Apr', 32),
                              ChartData('May', 40)
                            ],
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y
                        )
                      ]
                  ),
                  visible: isVisible,
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
