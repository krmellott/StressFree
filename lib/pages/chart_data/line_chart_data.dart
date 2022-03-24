import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '/model/stressFree_Model.dart';

final modelReference = new stressFree_Model();

List<Color> lineColor = [
  Colors.black,
];

List<LineChartBarData> lineChartBarData = [
  LineChartBarData(
      colors: lineColor,
      isCurved: true,
      spots: [
        //add database data here
        //day on x, mood on y
        //FlSpot(getDay()[i].toDouble(), getMood()[i].toDouble()),
        //...
        FlSpot(1, 5),
        FlSpot(2, 2),
        FlSpot(3, 1),
        FlSpot(4, 4),
        FlSpot(5, 3),
        FlSpot(6, 3),
        FlSpot(7, 4)
      ]
  )
];

/* List<int> getMood (){
   modelReference.dbRetrieveMoods();
 }

 List<int> getDay(){
   modelReference.dbRetrieveMoods();
 } */