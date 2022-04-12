import 'package:firstapp/model/StressFreeModel.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class VideoScreen extends StatefulWidget {
  final String collectionPath;
  const VideoScreen({Key? key, required this.collectionPath}) : super(key: key);

  @override
  _VideoScreen createState() => _VideoScreen();
}

class _VideoScreen extends State<VideoScreen> {
  Color _iconColor = Colors.grey;
  final modelReference = new StressFreeModel();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(widget.collectionPath)
              .snapshots(), //_getCollectionPath(widget.collectionPath),
          builder: (context, AsyncSnapshot snapshot) {
            String collection = widget.collectionPath.toString();
            if (!snapshot.hasData) return const Text('Loading...');
            return ListView(
              children: snapshot.data!.docs.map<Widget>((document) {
                var url = document['url'];
                YoutubePlayerController _controller = YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(url)!,
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                    isLive: false,
                    loop: false,
                    forceHD: false,
                    controlsVisibleAtStart: false,
                  ),
                );
                return Expanded(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        YoutubePlayer(
                          controller: _controller,
                          liveUIColor: Colors.blue,
                        ),
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
                            ),

                            IconButton(
                              icon: Icon(
                                Icons.bookmark_border_sharp,
                                size: 30.0,
                                color: _iconColor = document['isFavorite']
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              onPressed: () {
                                if (_iconColor == Colors.red) {
                                  FirebaseFirestore.instance
                                      .collection(collection)
                                      .doc(document['name'])
                                      .update({'isFavorite': true});
                                  setState(() {
                                    color:
                                    _iconColor = document['isFavorite']
                                        ? Colors.green
                                        : Colors.red;
                                  });
                                  modelReference.dbInsertVideo(
                                      true, document['name'], url);
                                }
                                if (_iconColor == Colors.green) {
                                  FirebaseFirestore.instance
                                      .collection(collection)
                                      .doc(document['name'])
                                      .update({'isFavorite': false});
                                  setState(() {
                                    color:
                                    _iconColor = document['isFavorite']
                                        ? Colors.green
                                        : Colors.red;
                                  });
                                  modelReference.dbRemoveVideo(
                                      collection, document['name']);
                                }
                              },
                            )
                            // _favoriteIcon()
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
