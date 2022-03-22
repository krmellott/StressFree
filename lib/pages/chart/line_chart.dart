import 'package:fl_chart/fl_chart.dart';
import '/pages/chart_data/line_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class LineChartContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 1,
        minY: 0,
        maxX: 7,
        maxY: 16,
        lineBarsData: lineChartBarData,
      ),
    );
  }
}