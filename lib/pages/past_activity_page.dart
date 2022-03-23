
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PastActivities extends StatefulWidget {
  @override
  _PastActivities createState() => _PastActivities();
}

class _PastActivities extends State<PastActivities> {
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Activities'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Activity history here.'),
          ],

        )
      )
    );
  }
}