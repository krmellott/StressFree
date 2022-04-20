import 'package:firstapp/utils/video_player.dart';
import 'package:flutter/material.dart';

class Meditation extends StatelessWidget {
  const Meditation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meditation"),
      ),
      body: Column(
        children: [
          VideoPlayer(collectionPath: 'meditation videos'),
        ],
      ),
    );
  }
}
