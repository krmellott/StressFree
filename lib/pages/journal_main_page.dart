import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/utils/add_journal_entry.dart';
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
      body: Column (
        children: [
          Text('Sorry, it seems this page is still under construction. Please come back later.'
              ' Or try out the "new Journal" button, that one should be working by now.'),
        ]
      ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return AddEntry();
              }));
              },
            backgroundColor: Colors.green,
            label: const Text('New Journal Entry')
        )
    );
  }
}