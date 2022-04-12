import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/utils/add_journal_entry.dart';
import 'package:flutter/material.dart';

class MainJournal extends StatefulWidget {
  @override
  _MainJournal createState() => _MainJournal();
}

class _MainJournal extends State<MainJournal> {
  @override
  String dropDownValue = "default";
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Journal'),
      ),
      body: Column (
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 5.0),
            child: Row(
              children: [
                Text("Your Journals:",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    )
                ),
                /*DropdownButton(
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    icon: const Icon(Icons.arrow_downward),
                    onChanged: (String? newDate) {
                      setState((){
                        dropDownValue = newDate!;
                      });
                    }
                )*/
              ]
            )
          ),

          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('journal').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Text('We didn\'t find any journals for you');
                    return new ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          return _buildJournalListItem(context, snapshot.data!.docs[index]);
                        }
                    );
                  }
              )
          ),
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

/**
 * Creates a list of all journal in order of creation from most recent to least
 * Returns a card consisting of the title and the body
 */
Widget _buildJournalListItem(BuildContext context,DocumentSnapshot document) {
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