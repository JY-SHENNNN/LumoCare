import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryTabView extends StatelessWidget {
  const HistoryTabView({super.key});

  Future<List<FlSpot>> fetchLuxData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final uid = currentUser?.uid;
    final snapshot = await FirebaseFirestore.instance //get stored value from collection light_data and username
        .collection('light_data')
        .doc(uid)
        .collection('hourly_data')
        .get();

    final List<FlSpot> points = [];
    // generate points for the graph
    for (var doc in snapshot.docs) {
      final hour = double.tryParse(doc.id) ?? -1;
      final lux = (doc['lux'] as num).toDouble();
      if (hour >= 0 && hour < 24) {
        points.add(FlSpot(hour, lux));
      }
    }

    points.sort((a, b) => a.x.compareTo(b.x));
    return points;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final username = currentUser?.displayName ?? "Users";
    return Scaffold(
      appBar: AppBar(
        title: Text("$username's Light History ",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            //Color.fromARGB(255, 142, 171, 162),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 121, 119, 113),
      ),
      body: Container(
        color: Color.fromARGB(255, 219, 215, 205),
        child: FutureBuilder<List<FlSpot>>(
          future: fetchLuxData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final luxPerHour = snapshot.data!;
            double avgLux = 0;
            String rating = "⭐️☆☆☆☆";
            String comment = "No data available for today.";

            if (luxPerHour.isNotEmpty) {
              avgLux = luxPerHour.map((e) => e.y).reduce((a, b) => a + b) / luxPerHour.length;

              if (avgLux < 100) {
                rating = "⭐️☆☆☆☆";
                comment = "Light is too weak today. Consider increasing light exposure.";
              } else if (avgLux < 300) {
                rating = "⭐️⭐️☆☆☆";
                comment = "Some areas are too dim, suitable for relaxation but not for work.";
              } else if (avgLux < 500) {
                rating = "⭐️⭐️⭐️⭐️☆";
                comment = "Moderate lighting, good for study/work. Remember to take breaks.";
              } else {
                rating = "⭐️⭐️⭐️⭐️⭐️";
                comment = "Excellent lighting! Perfect for tasks, but don't forget to rest.";
              }
            }
  
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: 23,
                        minY: 0,
                        maxY: 1000,
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 200,
                              reservedSize: 40,
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

                // mark system to illustrate today's light
                 Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "💡 Daily Light Comfort Rating",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "$rating\n$comment",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
