import 'package:firstapp/utils/add_videos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MuscleRelaxion extends StatelessWidget {
  const MuscleRelaxion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Muscle Relaxation"),
      ),
      body: Column(
        children: [
          VideoScreen(collectionPath: 'guided muscle relaxation')
        ],
      ),
    );
  }
}
