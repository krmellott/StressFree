import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/model/StressFreeModel.dart';
import 'package:firstapp/pages/past_activity_page.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryPage extends StatefulWidget {
  @override
  ActivitiesCalendar createState() => ActivitiesCalendar();
}

class ActivitiesCalendar extends State<HistoryPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  //DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  final modelReference = new StressFreeModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Activity Calendar"),
        ),
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.lightBlueAccent, Colors.white])),
                child: Column(children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2000, 1, 1),
                    lastDay: DateTime.utc(2050, 12, 31),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      //used to determine which day has been selected by the user
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      //highlights the day the user selected
                      setState(() {
                        _selectedDay = selectedDay;
                        //_focusedDay = focusedDay;
                      }); //setState
                    },
                    // onDaySelected
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      }); //setState
                    },
                    //onFormatChanged
                    onPageChanged: (focusedDay) {
                      //_focusedDay = focusedDay;
                    }, //onPageChanged
                  ),

                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigoAccent,
                          shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(
                                  20.0)),
                          minimumSize: Size(225, 50),
                          maximumSize: Size(225, 50)),
                      icon: Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      label: Text('Completed Activities',
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'ComicSans',
                              fontSize: 16)),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return PastActivities();
                        }));
                      },
                    ),

                  Expanded(
                      child: StreamBuilder(
                          stream: modelReference.dbRetrieveActivities(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Text('No activities found.');
                            return new ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  return _buildListItem(
                                      context, snapshot.data!.docs[index]);
                                });
                          })),
                ]))));
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    var data = document.data() as Map<String, dynamic>;
    if (data['status'] == false &&
        data['date'][2] == _selectedDay?.year &&
        data['date'][0] == _selectedDay?.month &&
        data['date'][1] == _selectedDay?.day) {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          child: ListTile(
            title: Text(data['title']),
            subtitle: Text('Due date: ' +
                data['date'].toString() +
                '\nPriority: ' +
                data['priority'].toString()),
          ),
        ),
      );
    }
    return SizedBox(width: 0, height: 0);
  }
}
