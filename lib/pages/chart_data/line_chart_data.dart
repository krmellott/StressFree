import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Color> lineColor = [
  Color(0xfff3f169),
];

List<LineChartBarData> lineChartBarData = [
  LineChartBarData(
      colors: lineColor,
      isCurved: true,
      spots: [
        //add database data here
        //day on x, mood on y
        FlSpot(8, 5),
        //...
      ]
  )
];