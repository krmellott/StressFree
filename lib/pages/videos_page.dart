import 'package:firstapp/pages/VideoScreens/cat_videos.dart';
import 'package:firstapp/pages/VideoScreens/deep_breathing.dart';
import 'package:firstapp/pages/VideoScreens/meditation.dart';
import 'package:firstapp/pages/VideoScreens/muscle_relaxation.dart';
import 'package:firstapp/utils/image_buttons.dart';
import 'package:firstapp/utils/video_images.dart';
import 'package:firstapp/controller/stressFree_Controller.dart';
import 'package:firstapp/model/stressFree_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPage createState() => _VideosPage();
}

class _VideosPage extends State<VideosPage> {
  bool isVisible = false;
  Color color = Colors.grey;
  String? selected = 'Meditation';
  final controllerReference = new stressFree_Controller();
  final modelReference = new stressFree_Model();
  List<String> genre = ['Meditation',
    'Deep Breathing', 'Cute Cat Videos', 'Muscle Relaxation'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Videos"),
      ),
      body: Container(
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
                  label: "Bookmarks",
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return CatVideos();
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