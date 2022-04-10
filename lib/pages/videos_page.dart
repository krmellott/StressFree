import 'package:firstapp/pages/VideoScreens/cat_videos.dart';
import 'package:firstapp/pages/VideoScreens/deep_breathing.dart';
import 'package:firstapp/pages/VideoScreens/favorite_page.dart';
import 'package:firstapp/pages/VideoScreens/meditation.dart';
import 'package:firstapp/pages/VideoScreens/muscle_relaxation.dart';
import 'package:firstapp/utils/image_buttons.dart';
import 'package:firstapp/utils/video_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPage createState() => _VideosPage();
}

class _VideosPage extends State<VideosPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Videos"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.lightBlueAccent,
                  Colors.white
                ]
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageButton(
                  label: "Meditation Videos",
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return Meditation();
                      })),
                  image: VideoImage.meditation
              ),
              ImageButton(
                  label: "Deep Breathing Videos",
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return DeepBreathing();
                      })),
                  image: VideoImage.breathing
              ),
              ImageButton(
                  label: "Muscle Relaxation Videos",
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return MuscleRelaxion();
                      })),
                  image: VideoImage.relaxation
              ),
              ImageButton(
                  label: "Cute Cat Videos",
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return CatVideos();
                      })),
                  image: VideoImage.cuteCats
              ),
              ImageButton(
                  label: "Favorite Videos",
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return FavoriteVideos();
                      })),
                  image: VideoImage.favorites
              ),
            ],
          ),
        ),
      ),
    );
  }

}