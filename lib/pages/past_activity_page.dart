import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/controller/stressFree_Controller.dart';
import 'package:firstapp/model/StressFreeModel.dart';
import 'package:firstapp/pages/mood_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PastActivities extends StatefulWidget {
  @override
  _PastActivities createState() => _PastActivities();
}

class _PastActivities extends State<PastActivities> {
  final modelReference = new StressFreeModel();
  final controller = new StressFreeController();
  final _subHeadingFont2 = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);
  final _subHeadingFont3 = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Completed Activities'),
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.lightBlueAccent, Colors.white])),
            child: Center(
                child: Column(children: [
              _buildActivityGraph(context),
              _buildActivitiesView(context)
            ]))));
  }

  // _buildStreamBuilder(BuildContext context) {
  //   print("Building the stream!");
  //   return StreamBuilder(
  //       stream: modelReference.dbRetrieveActivities(),
  //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         print("flag 1 - within streambuilder");
  //         if (!snapshot.hasData)
  //           return Text('No completed activities.',
  //               style: const TextStyle(
  //                   fontWeight: FontWeight.bold, color: Colors.black45),
  //               textScaleFactor: 1.25);

  //         return ListView.builder(
  //             itemCount: snapshot.data?.docs.length,
  //             itemBuilder: (context, index) {
  //               if (snapshot.data?.docs[index]['status'] == true) {
  //                 final title = snapshot.data?.docs[index]['title'];
  //                 final date = snapshot.data?.docs[index]['date'];
  //                 final priority = snapshot.data?.docs[index]['priority'];

  //                 return Padding(
  //                     padding: EdgeInsets.only(top: 5.0),
  //                     child: Card(
  //                       margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
  //                       child: ListTile(
  //                           title: Text(title),
  //                           subtitle: Text('Due date: ' +
  //                               date.toString() +
  //                               '\nPriority: ' +
  //                               priority.toString()),
  //                           onTap: () {
  //                             _updateActivityStatus(
  //                                 context, title, priority, date);
  //                           }),
  //                     ));
  //               }
  //               return SizedBox(width: 0, height: 0);
  //             });
  //       });
  // }

  _buildActivitiesView(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: modelReference.orderedActivities('activity', 'date'),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data!.docs[index]),
            );
          }),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    var data = document.data() as Map<String, dynamic>;
    DateTime currentDate = DateTime.now();
    if (data['status'] == true) {
      Text labelTitle = new Text(data['title'], style: _subHeadingFont2);
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          child: ListTile(
            title: labelTitle,
            subtitle: Text(
              'Due date: ' +
                  data['date'].toString() +
                  '\nPriority: ' +
                  data['priority'].toString(),
              style: _subHeadingFont3,
            ),
            onTap: () {
              _updateActivityStatus(
                  context, data['title'], data['priority'], data['date']);
            },
          ),
        ),
      );
    }
    return SizedBox(width: 0, height: 0);
  }

  _updateActivityStatus(
      BuildContext context, String title, String priority, List date) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Colors.lightBlueAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)),
                Text(
                    'Due date: ' +
                        date.toString() +
                        '\nPriority: ' +
                        priority.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.white)),
                ElevatedButton(
                    child: const Text('Mark as Incomplete'),
                    onPressed: () {
                      controller.updateActivityCompletion(title, false);
                      Navigator.pop(context);
                    }),
                ElevatedButton(
                    child: const Text('Delete Activity'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent)),
                    onPressed: () {
                      controller.deleteActivity(title);
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildActivityGraph(BuildContext context) {
    //return Container(child: Text("To be continued..."));
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: StreamBuilder(
            stream: modelReference.retrieveCompletedActivities(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Text('No past moods.');

              List<ChartData> dataSet = <ChartData>[];
              var numberOfActivities = [0, 0, 0, 0, 0, 0, 0];
              List<String> dates = <String>[];
              int currentIndex = 0;
              List<int> currentDate = [0, 0, 0];
              snapshot.data?.docs.forEach((doc) {
                var date = doc['date'];
                print("\nChecking this date: " + date.toString());
                if (compareDates(currentDate, [0, 0, 0])) {
                  print('Current date is 0, 0, 0');
                  dates.add(dateFormat(date));
                  numberOfActivities[currentIndex] = 1;
                  currentDate[0] = date[0];
                  currentDate[1] = date[1];
                  currentDate[2] = date[2];
                } else if (compareDates(currentDate, date)) {
                  print('Compare dates check');
                  numberOfActivities[currentIndex] += 1;
                } else {
                  print('if all else fails');
                  dates.add(dateFormat(date));
                  currentIndex += 1;
                  numberOfActivities[currentIndex] = 1;
                  currentDate[0] = date[0];
                  currentDate[1] = date[1];
                  currentDate[2] = date[2];
                }
              });

              numberOfActivities.forEach(print);

              currentIndex = 0;
              var maxElement = 0.0;
              dates.forEach((element) {
                dataSet.add(
                    ChartData(element, numberOfActivities[currentIndex] + 0.0));
                print('Data being entered: ' +
                    element +
                    ', ' +
                    (numberOfActivities[currentIndex] + 0.0).toString());
                if (numberOfActivities[currentIndex] > maxElement) {
                  maxElement = numberOfActivities[currentIndex] + 0.0;
                }
                currentIndex++;
              });

              print("dataSet length: " + dataSet.length.toString());

              return SfCartesianChart(
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePinching: true,
                    zoomMode: ZoomMode.x,
                    enablePanning: true,
                  ),
                  primaryXAxis: CategoryAxis(
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  title: ChartTitle(text: 'Activities Graph'),
                  primaryYAxis: NumericAxis(
                    maximum: maxElement,
                    minimum: 0,
                    isVisible: true,
                  ),
                  series: <ChartSeries>[
                    LineSeries<ChartData, String>(
                        color: Color.fromARGB(255, 0, 0, 0),
                        markerSettings: MarkerSettings(
                          isVisible: true,
                        ),
                        dataSource: dataSet,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y)
                  ]);

              //return Text('to be continued...');
            }));
  }

  String dateFormat(var date) {
    return date[0].toString() +
        '/' +
        date[1].toString() +
        '/' +
        date[2].toString().substring(2, 4);
  }

  bool compareDates(List lhsDate, List rhsDate) {
    return (lhsDate[0] == rhsDate[0]) &&
        (lhsDate[1] == rhsDate[1]) &&
        (lhsDate[2] == rhsDate[2]);
  }
}
