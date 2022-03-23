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
        minX: 0,
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
            showTitles: true,
            getTitles: (value) {
              return value.toInt().toString();
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