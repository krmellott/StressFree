import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import '/pages/chart_data/line_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LineChartContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 1,
        minY: 1,
        maxX: 7,
        maxY: 5,
        lineBarsData: lineChartBarData,
        titlesData: FlTitlesData(
          leftTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return 'Angry';
                case 2:
                  return 'Sad';
                case 3:
                  return 'Neutral';
                case 4:
                  return 'Happy';
                case 5:
                  return 'Elated';
              }
              return '';
            },
          ),
          bottomTitles: SideTitles(
            interval: 1,
            showTitles: true,
            textAlign: TextAlign.center,
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return 'Mon';
                case 2:
                  return 'Tues';
                case 3:
                  return 'Wed';
                case 4:
                  return 'Thu';
                case 5:
                  return 'Fri';
                case 6:
                  return 'Sat';
                case 7:
                  return 'Sun';
              }
              return '';
            },
          ),
          rightTitles: SideTitles(
            showTitles: false,
          ),
          topTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
    );
  }
}
