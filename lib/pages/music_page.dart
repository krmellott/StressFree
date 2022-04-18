import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../model/StressFreeModel.dart';

class MusicPage extends StatefulWidget {
  @override
  _MusicPage createState() => _MusicPage();
}

class _MusicPage extends State<MusicPage> {
  final modelReference = new StressFreeModel();
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Expanded(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('relaxing music')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return ListView(
              children: snapshot.data!.docs.map<Widget>((document) {
                var url = document['url'];
                return Expanded(
                  child: Card(
                    child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10),
                                  child: Text(document['name'],
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),

                                ),
                              )
                ],
                              ),
                             Row(
                               children: [
                              IconButton(
                                icon: Icon(
                                  Icons.play_arrow,
                                  size: 20.0,
                                  color: Colors.black
                                  ),
                                  onPressed: (){
                                    audioPlayer.play(url);
                                  },
                                ),
                             IconButton(
                               icon: Icon(
                                  Icons.stop,
                                  size: 20.0,
                                  color: Colors.black
                                  ),
                                  onPressed: (){
                                     audioPlayer.stop();
                                   },
                                 ),
                              ]

                          )
                        ]
                    ),
                  ),
                );
              }).toList(),

            );
          }),
    );

  }
}
