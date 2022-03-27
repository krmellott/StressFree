import 'dart:collection';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firstapp/controller/stressFree_Controller.dart';
import 'package:firstapp/model/stressFree_Model.dart';
import 'package:firstapp/utils/addTask_page.dart';
import 'package:firstapp/utils/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivitiesPage extends StatefulWidget {
  @override
  _ActivitiesPage createState() => _ActivitiesPage();
}

class _ActivitiesPage extends State<ActivitiesPage> {
  final _subHeadingFont = TextStyle(
      fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.grey);
  final _subHeadingFont1 = TextStyle(
      fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black);
  final _headingFont = TextStyle(
      fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black);
  final controllerReference = new stressFree_Controller();
  final modelReference = new stressFree_Model();
  DateTime _selectedDate = DateTime.now();
  var date = DateTime(0, 0, 0);
  String? selected;
  List<String> sortBy = ['Date', 'Title', 'Priority'];

  stressFree_Model model = stressFree_Model();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activities"),
      ),
      body: Column(children: [
        _addTaskBar(context),
        _addDatePicker(),
        _taskColumn(),
      ]),
    );
  }

  // function to get the current date using the intl package
  _addTaskBar(BuildContext context) {
    Queue aQueue;
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
                onTap: () => {
                      //modelReference.dbInsertMood(Moods.Neutral, [1, 1, 2000])
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return AddTask();
                      }))
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
        onDateChange: (date) {
          _selectedDate = date; // storing selected date into a variable
        },
      ),
    );
  }

  //todo: Create a string navigation of dialogues.
  _insertDialogueTask(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('Insert Activity'),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tell us what you did!',
            ),
          ),
          RaisedButton(onPressed: Navigator.of(context).pop)
        ],
      ),
    );
  }

  _insertDialogueDate(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('When did you finish the task?'),
        children: <Widget>[
          Container(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                date = newDateTime;
              },
            ),
          ),
          RaisedButton(onPressed: Navigator.of(context).pop)
        ],
      ),
    );
  }

  _taskColumn() {
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
                _insertDropDownMenu(),
              ],
            )
          ],
        ))));
  }

  _insertDropDownMenu() {
    return DropdownButton<String>(
        value: selected,
        items: sortBy.map(buildMenuItem).toList(),
        onChanged: (value) => setState(() => selected = value),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        hint: Text('Sort by: ',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ));
}
