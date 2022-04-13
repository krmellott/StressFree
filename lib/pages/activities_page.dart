import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firstapp/controller/stressFree_Controller.dart';
import 'package:firstapp/model/StressFreeModel.dart';
import 'package:firstapp/utils/addTask_page.dart';
import 'package:firstapp/utils/buttons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/units_constant.dart';

class ActivitiesPage extends StatefulWidget {
  @override
  _ActivitiesPage createState() => _ActivitiesPage();
}

class _ActivitiesPage extends State<ActivitiesPage> {
  final _subHeadingFont = TextStyle(
      fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black);
  final _subHeadingFont1 = TextStyle(
      fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black);
  final _subHeadingFont2 = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);
  final _subHeadingFont3 = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.grey);
  final _headingFont = TextStyle(
      fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black);
  final controllerReference = new StressFreeController();
  final modelReference = new StressFreeModel();
  var date = DateTime(0, 0, 0);
  String? selected = 'Date';
  List<String> sortBy = ['Date', 'Title', 'Priority'];

  StressFreeModel model = new StressFreeModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activities"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlueAccent, Colors.white])),
        child: Column(
          children: [
            _addTaskBar(context),
            _addDatePicker(),
            _taskColumn(context),
            _sortActivities(selected, context)
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    var data = document.data() as Map<String, dynamic>;
    if (data['status'] == false) {
      print("document data is false with " + data['title'].toString());
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          child: ListTile(
            title: Text(
              data['title'],
              style: _subHeadingFont2,
            ),
            subtitle: Text(
              'Due date: ' +
                  data['date'].toString() +
                  '\nPriority: ' +
                  data['priority'].toString(),
              style: _subHeadingFont3,
            ),
            onTap: () {
              _editActivity(data);
            }, //() {
            // print('This is the title of the data: ' + data['title']);
            // String activityName = data['title'];
            // showModalBottomSheet<void>(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return Container(
            //       height: 500,
            //       color: Colors.white,
            //       child: Center(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           mainAxisSize: MainAxisSize.min,
            //           children: <Widget>[
            //             const Text('Edit your activity!',
            //                 style: TextStyle(
            //                     fontSize: 40, decorationThickness: 20.0)),
            //             Text(activityName),
            //             Container(
            //                 margin: const EdgeInsets.only(
            //                     left: 10, right: 10, top: 20),
            //                 child: TextField(
            //                   controller: TextEditingController()
            //                     ..text = activityName,
            //                   decoration: InputDecoration(
            //                     border: OutlineInputBorder(),
            //                     labelText: 'Activity',
            //                   ),
            //                   onChanged: (String? message) {
            //                     setState(() {
            //                       activityName = message!;
            //                     });
            //                   },
            //                 )),
            //             ElevatedButton(
            //               child: const Text('Submit request!'),
            //               onPressed: () => Navigator.pop(context),
            //             )
            //           ],
            //         ),
            //       ),
            //     );
            //},
          ),
        ),
      );
    }
    return SizedBox(width: 0, height: 0);
  }

  _addTaskBar(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Get current date and time
                  Text(DateFormat.yMMMMd().format(DateTime.now()),
                      style: _subHeadingFont),
                  Text(
                    "Today",
                    style: _headingFont,
                  ),
                ],
              ),
            ),
            MyButton(
                label: "+Add Task",
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return AddTask();
                  }));
                }),
          ],
        ));
  }

  _addDatePicker() {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: Colors.blue,
        dateTextStyle: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        dayTextStyle: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
        monthTextStyle: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        onDateChange: (date) {},
      ),
    );
  }

  _taskColumn(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
        child: Expanded(
            child: SingleChildScrollView(
                child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'My Activities',
                  style: _subHeadingFont1,
                ),
                _insertDropDownMenu(context),
              ],
            ),
            // _buildActivitiesList()
          ],
        ))));
  }

  _insertDropDownMenu(BuildContext context) {
    return DropdownButton<String>(
      value: selected,
      items: sortBy.map(buildMenuItem).toList(),
      onChanged: (value) => setState(() => {
            selected = value,
          }),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
      // hint: Text('Sort by: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ));

  _sortActivities(String? label, BuildContext context) {
    switch (label) {
      case 'Date':
        return Expanded(
          //child:
          // FutureBuilder(
          //   future: _userID,
          //   builder:
          //   )
          child: StreamBuilder(
              stream: modelReference.orderedActivities('activity', 'date'),
              // FirebaseFirestore.instance
              //     .collection('activity')
              //     .orderBy('date')
              //     //.where('userID', isEqualTo: '$_userID')
              //     .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, snapshot.data!.docs[index]),
                );
              }),
        );
      case 'Title':
        return Expanded(
          child: StreamBuilder(
              stream: modelReference.orderedActivities('activity', 'title'),
              // FirebaseFirestore.instance
              //     .collection('activity')
              //     .orderBy('title')
              //     .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, snapshot.data!.docs[index]),
                );
              }),
        );
      case 'Priority':
        return Expanded(
          child: StreamBuilder(
              stream: modelReference.orderedActivitiesWithSort(
                  'activity', 'priority', true),
              // FirebaseFirestore.instance
              //     .collection('activity')
              //     .orderBy('priority', descending: true)
              //     .snapshots(),
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
  }

  _editActivity(var data) {
    print('This is the title of the data: ' + data['title']);
    String activityName = data['title'];
    TaskCompleted _taskCompleted = TaskCompleted.NO;
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 500,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Activity Editor',
                      style:
                          TextStyle(fontSize: 32, decorationThickness: 20.0)),
                  Text(activityName),
                  Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: TextField(
                        controller: TextEditingController()
                          ..text = activityName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Activity',
                        ),
                        onChanged: (String? message) {
                          setState(() {
                            activityName = message!;
                          });
                        },
                      )),
                  ElevatedButton(
                    child: const Text('Complete Task!'),
                    onPressed: () {
                      controllerReference.updateActivityCompletion(
                          activityName, true);
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Submit Change'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
          );
        });
  }
}
