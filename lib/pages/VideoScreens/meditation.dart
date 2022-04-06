import 'package:firstapp/utils/add_videos.dart';
import 'package:flutter/cupertino.dart';
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
          VideoScreen(collectionPath: 'meditation videos'),
        ],
      ),
    );
  }
}