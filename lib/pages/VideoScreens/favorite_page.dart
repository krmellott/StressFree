import 'package:firstapp/utils/add_videos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteVideos extends StatelessWidget {
  const FavoriteVideos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Videos"),
      ),
      body: Column(
        children: [
          VideoScreen(collectionPath: 'favorite videos')
        ],
      ),
    );
  }
}