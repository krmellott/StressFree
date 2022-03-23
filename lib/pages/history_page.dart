import 'package:firstapp/pages/past_activity_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// TODO: implement TableCalendar
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
      body: //Center (
      Column(
        children: [
          TableCalendar(
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
        ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.green
            ),
            child: Text('Edit Activities'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return PastActivities();
              }));
            },
          ),
        ]
      )
    );

   /* return Scaffold(
      body: Center(
        child: Text('Your History Here!'),
      ),
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
              });
            },
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.green
            ),
            child: Text('Edit Activities'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return PastActivities();
              }));
            },
          ),
        ]
      )
    );
    */

  }

}