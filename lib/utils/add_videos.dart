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
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(widget.collectionPath).snapshots(), //_getCollectionPath(widget.collectionPath),
          builder: (context, AsyncSnapshot snapshot) {
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
                  ),
                );
                return Expanded(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        YoutubePlayer(controller: _controller, liveUIColor: Colors.blue,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                                child: Text(document['name'],
                                    style: TextStyle(
                                        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black)
                                ),
                              ),
                            ),
                            // SizedBox(width: 50),
                            IconButton(
                                icon: Icon(
                                    Icons.bookmark_border_sharp,
                                    size: 30.0,
                                    color: _iconColor
                                ),
                                onPressed: () {
                                  setState(() {
                                  });
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
          }
      ),
    );
  }
}

