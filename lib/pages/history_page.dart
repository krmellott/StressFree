import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// TODO: implement TableCalendar
// TODO: Change box color to match selected mood that day
// TODO: Allow user to click on day to view the activities they did that day
class HistoryPage extends StatefulWidget {
  @override
  ActivitiesCalendar createState() => ActivitiesCalendar();
}

class ActivitiesCalendar extends State<HistoryPage> {
  @override
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity Calendar"),
      ),
      body:TableCalendar(
        firstDay: DateTime.utc(2000,1,1),
        lastDay: DateTime.utc(2050,12,31),
        focusedDay: DateTime.now(),

        selectedDayPredicate: (day) { //used to determine which day has been selected by the user
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) { //highlights the day the user selected
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          }); //setState
        }, // onDaySelected
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          }); //setState
        },//onFormatChanged
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },//onPageChanged
      )
    );

    /*return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body:GridView.count(
          crossAxisCount: 7, //sets the grid to be 7 boxes wide
          //padding:,
          // Generate 35 widgets that display their index in the List.
          children: List.generate(35, (index) {
            return Center(
              child: Text(
                  'Day $index',
                  // this is theme stuff, we can worry about it later
                  //style: Theme.of(context).textTheme.headline5,
                ),
            );
          }),
        ),
      ),
    );*/
/*
    return Scaffold(
      body: Center(
        child: Text('Your History Here!'),
      ),
    );
    */

  }

}