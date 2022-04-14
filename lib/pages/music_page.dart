import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class MusicPage extends StatefulWidget {
  @override
  _MusicPage createState() => _MusicPage();
}

class _MusicPage extends State<MusicPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Music"),
        ),
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.lightBlueAccent, Colors.white])),
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('relaxing music')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 10.0,
                                  left: 20.0,
                                  right: 20.0),
                              child: Text('Loading Music',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.white),
                                  textScaleFactor: 1.5));
                        } else {
                          return Text (' ');
                        }
                      }),
                ],
              )),
        ));
  }
}
