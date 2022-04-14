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
    AudioPlayer audioPlayer = AudioPlayer();
    AudioCache audioCache = AudioCache(fixedPlayer: audioPlayer);
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
                  Column(
                    children: [
                      Text('audio name'),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: (){
                              audioCache.play('file name');
                            },
                            icon: Icon(
                              Icons.play_arrow,
                            ),
                          label: Text(''),),
                          ElevatedButton.icon(
                            onPressed: (){
                              audioPlayer.pause();
                            },
                            icon: Icon(
                              Icons.pause,
                            ),
                            label: Text(''),),
                          ElevatedButton.icon(
                            onPressed: (){
                              audioPlayer.stop();
                            },
                            icon: Icon(
                              Icons.stop,
                            ),
                            label: Text(''),)
                        ],
                      )
                    ],

                  ),
                ],
              )),
        ));
  }
}
