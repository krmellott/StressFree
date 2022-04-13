import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/utils/add_journal_entry.dart';
import 'package:flutter/material.dart';

class MainJournal extends StatefulWidget {
  @override
  _MainJournal createState() => _MainJournal();
}

class _MainJournal extends State<MainJournal> {
  @override
  String dropDownValue = "Sort By Date";

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Journal'),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.lightBlueAccent, Colors.white])),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 5.0),
                  child: Row(children: [
                    Text("Your Journals:",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                        DropdownButton(
                            items: <String>['One', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            icon: const Icon(Icons.arrow_downward),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownValue = newValue!;
                              });
                            }),
                      ])
                  ),
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('journal')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return Text('We didn\'t find any journals for you');
                        return new ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              return _buildJournalListItem(
                                  context, snapshot.data!.docs[index]);
                            });
                      })),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return AddEntry();
              }));
            },
            backgroundColor: Colors.green,
            label: const Text('New Journal Entry')));
  }
}

Widget _buildJournalListItem(BuildContext context, DocumentSnapshot document) {
  var data = document.data() as Map<String, dynamic>;
  return Padding(
    padding: const EdgeInsets.all(1.0),
    child: Card(
      child: ListTile(
        title: Text(data['title'] + " - - - " + data['date'].toString()),
        subtitle: Text(data['body']),
      ),
    ),
  );
}
