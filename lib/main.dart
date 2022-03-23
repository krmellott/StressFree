import 'dart:core';
import 'dart:ffi';

import 'package:firstapp/pages/activities_page.dart';
import 'package:firstapp/pages/home_page.dart';
import 'package:firstapp/pages/mood_page.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Home());
}

//
// class Home1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(
//           primaryColor: Colors.green,
//         ),
//         home: Builder(
//             builder: (context) => Scaffold(
//                   appBar: AppBar(
//                     title: Text("StressFree!"),
//                   ),
//                   body: Center(
//                       child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
//                         child: Text(
//                           "StressFree!",
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold, color: Colors.green),
//                           textScaleFactor: 4,
//                         ),
//                       ),
//                     ],
//                   )),
//                 )));
//   }
// }

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StressFree!',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error: ${snapshot.error.toString()}');
            return Text("Something went wrong!");
          } else if (snapshot.hasData) {
            return RandomWords();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class LikedHistory extends StatefulWidget {
  @override
  _LikedHistoryState createState() => _LikedHistoryState();
}

class _LikedHistoryState extends State<LikedHistory> {
  final dbRef = FirebaseDatabase.instance.reference().child("liked");
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _saved = <WordPair>{};
  final _savedTime = <String>{};
  List<Map<dynamic, dynamic>> dataList = [];
  List<Map<dynamic, dynamic>> dataTimeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liked History"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, _saved);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: FutureBuilder(
          future: dbRef.once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              dataList.clear();
              dataTimeList.clear();
              if (snapshot.data!.value == null) {
                print("No Liked History...");
                return Text("No Liked History...");
              }
              Map<dynamic, dynamic> values = snapshot.data!.value;
              values.forEach((key, values) {
                dataList.add(values);
                final reg = RegExp(r"(?=[A-Z])");
                var parts = values['name'].split(reg);
                _saved.add(WordPair(parts[0], parts[1]).toLowerCase());
              });
              return new ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(16.0),
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                            trailing: Icon(Icons.delete),
                            title: Text(dataList[index]['name'],
                                style: _biggerFont),
                            onTap: () => dbRef
                                    .orderByChild('name')
                                    .equalTo(dataList[index]['name'])
                                    .once()
                                    .then((DataSnapshot snapshot) {
                                  Map<dynamic, dynamic> children =
                                      snapshot.value;
                                  children.forEach((key, value) {
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child('liked')
                                        .child(key)
                                        .remove();
                                  });
                                  setState(() {});
                                })),
                      ],
                    ),
                  );
                },
              );
            }
            return Text("Something went wrong!");
          }),
    );
  }
}

class _RandomWordsState extends State<RandomWords> {
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("liked");
  final _suggestions = <WordPair>[];
  final _timeSuggestions = <String>[];
  var _saved = <WordPair>{};
  final _savedTime = <String>{};
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StressFree!'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () async {
              final data = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LikedHistory()));
              //_saved = data;
              setState(() {
                _saved = data;
              });
            },
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  String generateDate() {
    var rng = new Random();
    //  nextInt(100) means the range 0 - 99
    var month = (rng.nextInt(12) + 1).toString(); // Minimum is 1, Maximum is 12
    var day = (rng.nextInt(31) + 1).toString(); // Minimum is 1, Maximum is 31
    var yearList = [
      2021,
      2022,
      2023,
      2024
    ]; // This is why we are going to be paid the big bucks folks.
    var yearSelector = rng.nextInt(4);
    var year = yearList[yearSelector].toString();

    var hour = (rng.nextInt(12) + 1).toString();
    var timeList = ["AM", "PM"];
    var timeTypeSelector = rng.nextInt(2);
    var time = timeList[timeTypeSelector].toString();

    var dateTime = "$month/$day/$year $hour:00 $time";

    return dateTime;
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
            for (var i = 0; i < 10; ++i) {
              _timeSuggestions.add(generateDate());
            }
          }
          return _buildRow(_suggestions[index], _timeSuggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair, String dateTime) {
    final alreadySaved = _saved.contains(pair);
    //final alreadySavedTime = _savedTime.contains(dateTime);
    DatabaseReference _likedRef =
        FirebaseDatabase.instance.reference().child("liked");
    return ListTile(
      title: Text(
        pair.asCamelCase,
        style: _biggerFont,
      ),
      subtitle: Text(dateTime),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
            _likedRef
                .orderByChild('name')
                .equalTo(pair.asCamelCase.toString())
                .once()
                .then((DataSnapshot snapshot) {
              if (snapshot.value != null) {
                Map<dynamic, dynamic> children = snapshot.value;
                children.forEach((key, value) {
                  FirebaseDatabase.instance
                      .reference()
                      .child('liked')
                      .child(key)
                      .remove();
                });
              }
            });
          } else {
            _saved.add(pair);
            _savedTime.add(dateTime);

            // Potential way to add the dateTime to the database to be displayed in the liked history section
            //_likedRef.child("name").child(pair.asCamelCase.toString()).set({"date":dateTime});
            _likedRef.push().child('name').set(pair.asCamelCase.toString());
          }
        });
      },
    );
  }
}
