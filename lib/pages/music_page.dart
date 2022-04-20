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
            width: 500,
            height: 5000,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.lightBlueAccent, Colors.white])),
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(20.0)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.0, right: 10.0),
                              child: Text('Baby Shark',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                  textScaleFactor: 1.5),
                            ),
                            Row(children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
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
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
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
                            ])
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(20.0)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.0, right: 10.0),
                              child: Text('Short Meditation Music',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                  textScaleFactor: 1.5),
                            ),
                            Row(children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: IconButton(
                                  onPressed: () async {
                                    await audioCache.play(
                                        'audio/audio/Short_Meditation_Music.mp3');
                                  },
                                  icon: Icon(
                                    Icons.play_arrow,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
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
                            ])
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(20.0)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.0, right: 10.0),
                              child: Text('Relaxing Guitar',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black),
                                  textScaleFactor: 1.5),
                            ),
                            Row(children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: IconButton(
                                  onPressed: () async {
                                    await audioCache.play(
                                        'audio/audio/Relaxing_guitar.mp3');
                                  },
                                  icon: Icon(
                                    Icons.play_arrow,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
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
                            ])
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
