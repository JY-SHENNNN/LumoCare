import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryTabView extends StatelessWidget {
  const HistoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> luxPerHour = List.generate(24, (hour) {
      double simulatedLux = (hour < 6 || hour > 19)
          ? (30 + hour).toDouble()
          : (100 + hour * 40).toDouble();
      return FlSpot(hour.toDouble(), simulatedLux); // x-> hour, y-> lux
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Light History"),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AspectRatio(
          aspectRatio: 1.6, 
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 23,
              minY: 0,
              maxY: 1100,
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 200,
                    getTitlesWidget: (value, meta) => Text(
                      '${value.toInt()}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 3,
                    getTitlesWidget: (value, meta) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('${value.toInt()}h',
                          style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                ),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                horizontalInterval: 200,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey[300]!,
                  strokeWidth: 1,
                  dashArray: [5, 5],
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.grey.shade400),
              ),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true, 
                  color: Colors.orange,
                  spots: luxPerHour,
                  barWidth: 3,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.orange.withOpacity(0.3),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
