import 'package:firstapp/pages/sounds_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/image_buttons.dart';
import '../utils/video_images.dart';
import 'music_page.dart';



class AudioPage extends StatefulWidget {
  @override
  _AudioPage createState() => _AudioPage();
}

class _AudioPage extends State<AudioPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Music and Sounds"),
        ),
        body: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlueAccent, Colors.white])),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ImageButton(
                  label: "Relaxing Music",
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                    return MusicPage();
                    })),
                    image: VideoImage.music),
                ImageButton(
                   label: "Soothing Sounds",
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return SoundsPage();
                    })),
                    image: VideoImage.sounds),
            ],
          ),
        ),
      ),
    );
  }
}