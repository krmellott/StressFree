import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class VideoScreen extends StatefulWidget {
  final String? collectionPath;
  const VideoScreen({Key? key, required this.collectionPath}) : super(key: key);

  @override
  _VideoScreen createState() => _VideoScreen();
}

class _VideoScreen extends State<VideoScreen> {
  Color _iconColor = Colors.grey;
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: _getCollectionPath(widget.collectionPath),
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

  _getCollectionPath(String? path){
    switch(path){
      case 'Meditation': return FirebaseFirestore.instance.collection('meditation videos').snapshots();
      case 'Deep Breathing': return FirebaseFirestore.instance.collection('deep breathing videos').snapshots();
      case 'Cute Cat Videos': return FirebaseFirestore.instance.collection('cute cat videos').snapshots();
      case 'Muscle Relaxation': return FirebaseFirestore.instance.collection('guided muscle relaxation').snapshots();
    }
  }

  // _favoriteIcon(){
  //   return IconButton(
  //       onPressed: (){
  //         // FirebaseFirestore.instance.collection('meditation videos')
  //         //     .doc('10 Minute Mindfulness Meditation').update({
  //         //   'isFavorite': !_isPressed
  //         // });
  //         // _isPressed = !_isPressed;
  //         setState(() {});
  //       },
  //       icon: Icon(
  //         Icons.star_border,
  //       )
  //   );
  // }

}

