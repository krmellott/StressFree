import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class VideoScreen extends StatelessWidget {
  // final String collectionPath;
  const VideoScreen({Key? key}) : super(key: key);
  // const VideoScreen({Key? key, required this.collectionPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          // stream: FirebaseFirestore.instance.collection(collectionPath).snapshots(),
          stream: FirebaseFirestore.instance.collection('videos').snapshots(),
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
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(document['name']),
                        ),
                        YoutubePlayer(controller: _controller, liveUIColor: Colors.blue,)
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

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    var data = document.data() as Map<String, dynamic>;
    if (data['status'] == false) {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          child: ListTile(
            title: Text(
              data['title'],
              // style: _subHeadingFont2,
            ),
            subtitle: Text(
              'Due date: ' +
                  data['date'].toString() +
                  '\nPriority: ' +
                  data['priority'].toString(),
              // style: _subHeadingFont3,
            ),
          ),
        ),
      );
    }
    return SizedBox(width: 0, height: 0);
  }

}

