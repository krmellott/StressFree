import 'package:flutter/material.dart';

import '../../utils/video_player.dart';

class FavoriteVideos extends StatelessWidget {
  const FavoriteVideos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Videos"),
      ),
      body: Column(
        children: [VideoPlayer(collectionPath: 'favorite videos')],
      ),
    );
  }
}
