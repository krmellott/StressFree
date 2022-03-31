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
  @override
  final controllerReference = new stressFree_Controller();
  final modelReference = new stressFree_Model();

  Widget build(BuildContext context) {
    /*   for (int i = 1; i < 5; i++) {
      String testDate = i.toString() + '/33/22';
      testList.add(ChartData(testDate, 2));
    } */
    return Scaffold(

        backgroundColor: color,
        appBar: AppBar(
          title: Text("Videos"),
        ),
        body: Center(
          child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text(
                    "Videos",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    textScaleFactor: 4,
                  ),
                ),
                Row(
                    children: [
                      Padding(
                      padding: EdgeInsets.all(20)
                      ),
                      new DropdownButton(
                          hint: Text('Please choose a topic'),
                          items: null, onChanged: null,
                          icon: const Icon(Icons.arrow_downward),
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                      ),
                    ],
                  ),
                ],


              )
          ),
        );
  }
}