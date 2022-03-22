import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firstapp/controller/stressFree_Controller.dart';
import 'package:firstapp/model/stressFree_Model.dart';
import 'package:firstapp/utils/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivitiesPage extends StatelessWidget {
  final _subHeadingFont = TextStyle(
      fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.grey);
  final _headingFont = TextStyle(
      fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black);
  final controllerReference = new stressFree_Controller();
  final modelReference = new stressFree_Model();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activities"),
      ),
      body: Column(children: [
        _addTaskBar(),
        _addDatePicker(),
      ]),
    );
  }

  // function to get the current date using the intl package
  _addTaskBar() {
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
              onTap: () => controllerReference
                  .insertActivityData("test1", false, [1, 2, 2000]))
        ],
      ),
    );
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
}
