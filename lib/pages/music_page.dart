import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// @dart=2.9

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
            child: Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Text('Baby Shark',
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black),
                            textScaleFactor: 1.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: IconButton(
                                onPressed: () async {
                                  await audioCache
                                      .play('audio/audio/Baby_Shark.mp3');
                                },
                                icon: Icon(
                                  Icons.play_arrow,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: IconButton(
                                onPressed: () {
                                  audioPlayer.pause();
                                },
                                icon: Icon(
                                  Icons.pause,
                                ),
                              ),
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: IconButton(
                                  onPressed: () {
                                    audioPlayer.stop();
                                  },
                                  icon: Icon(
                                    Icons.stop,
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
