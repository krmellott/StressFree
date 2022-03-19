import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firstapp/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivitiesPage extends StatelessWidget {
  final _subHeadingFont = TextStyle(fontSize: 24.0,
                                    fontWeight: FontWeight.bold, color: Colors.grey);
  final _headingFont = TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black);
  final _dateFont = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Activities"),
        ),
      body: Column (
        children: [
          _addTaskBar(),
          Container(
            margin: const EdgeInsets.only(top: 15, left: 10),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectedTextColor: Colors.white,
              selectionColor: Colors.blue,
              dateTextStyle: TextStyle(fontSize: 20.0,
                  fontWeight: FontWeight.bold, color: Colors.black),
              dayTextStyle: TextStyle(fontSize: 16.0,
                  fontWeight: FontWeight.bold, color: Colors.black),
              monthTextStyle: TextStyle(fontSize: 20.0,
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          )
        ]
      ),
    );
  }

  _addTaskBar(){
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
                Text("Today", style: _headingFont,),
              ],
            ),
          ),
          MyButton(label: "+Add Task", onTap: () => null)
        ],
      ),
    );
  }

}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// class ActivitiesPage extends StatefulWidget {
//   // @override
//   // _ActivitiesPage createState() => _ActivitiesPage();
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Center(
//         child: Text('Activities Page'),
//       ),
//     );
// }
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }

// // TODO: Request for new activities
// // TODO: Display new activities
//
// class _ActivitiesPage extends State<ActivitiesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Activities!',
//       theme: ThemeData(
//         primaryColor: Colors.blue,
//       ),
//     );
//   }
//
// }


// class _ActivitiesPage extends State<ActivitiesPage> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Center(
//         child: Text('Activities Page'),
//       ),
//     );
//   }

//}