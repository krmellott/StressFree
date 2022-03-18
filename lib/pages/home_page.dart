import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/pages/history_page.dart';
import 'package:firstapp/pages/mood_page.dart';
import 'package:flutter/material.dart';

import 'activities_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: Builder(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text("StressFree!"),
              ),
              body: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Text("StressFree!",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green), textScaleFactor: 4,)
                        ,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green
                        ),
                        child: Text('Enter Activity'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return ActivitiesPage();
                          }));
                        },
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green
                        ),
                        child: Text('Enter Mood'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return MoodPage();
                          }));
                        },
                      ),


                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green
                          ),
                          child: Text('History'),
                          onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                          return HistoryPage();
                        }));
                      },
                      )
                    ],
                  )
              ),
            )
        )
    );
  }
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
            return Text("here"); //change this
            //return RandomWords();
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

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}