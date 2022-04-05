import 'package:firstapp/utils/add_videos.dart';
import 'package:firstapp/utils/units_constant.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:firstapp/controller/stressFree_Controller.dart';
import 'package:firstapp/model/stressFree_Model.dart';
import '/utils/units_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPage createState() => _VideoPage();
}

class _VideoPage extends State<VideoPage> {
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
      body: Column(
        children: [
          _dropDownItems(context),
          VideoScreen(collectionPath: selected),
        ],
      ),
    );
  }

  _dropDownItems(BuildContext context) {
    return DropdownButton<String>(
      value: selected,
      items: genre.map(buildGenreItem).toList(),
      isExpanded: true,
      onChanged: (value) => setState(() => {
        selected = value,
      }),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
      hint: Text('Genre: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
    );
  }

  DropdownMenuItem<String> buildGenreItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      )
  );

}