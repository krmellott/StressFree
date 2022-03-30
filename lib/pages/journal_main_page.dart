import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainJournal extends StatefulWidget {
  @override
  _MainJournal createState() => _MainJournal();
}

class _MainJournal extends State<MainJournal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Journal'),
      ),
      body: Text('These are words. They don\'t mean anything yet'),
    );
  }
}