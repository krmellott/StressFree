import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoodPage extends StatefulWidget {
  @override
  _MoodPage createState() => _MoodPage();
}

class _MoodPage extends State<MoodPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood!',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}