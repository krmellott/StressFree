import 'package:firstapp/utils/add_videos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeepBreathing extends StatelessWidget {
  const DeepBreathing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deep Breathing"),
      ),
      body: Column(
        children: [
          VideoScreen(collectionPath: 'deep breathing videos')
        ],
      ),
    );
  }
}
