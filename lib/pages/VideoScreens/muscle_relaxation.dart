import 'package:flutter/material.dart';

import '../../utils/video_player.dart';

class MuscleRelaxion extends StatelessWidget {
  const MuscleRelaxion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Muscle Relaxation"),
      ),
      body: Column(
        children: [VideoPlayer(collectionPath: 'guided muscle relaxation')],
      ),
    );
  }
}
