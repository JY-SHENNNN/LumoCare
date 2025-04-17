import 'package:flutter/material.dart';
import 'history_tab.dart';

class HomeTabView extends StatelessWidget {
  final int lux;
  final String advice;

  const HomeTabView({super.key, required this.lux, required this.advice});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // current light intesity card
       Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Container(
            width: double.infinity, 
            height: 420,            
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wb_sunny, size: 48, color: Colors.orange),
                  const SizedBox(height: 12),
                  Text(
                    "Current: $lux lux",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text("Real-time reading", style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
        ),


        const SizedBox(height: 16),

        // advice card
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Container(
            width: double.infinity, 
            height: 180,            
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.remove_red_eye, color: Colors.blue, size: 32),
                  const SizedBox(height: 12),
                  Text(advice),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ),
        

        const SizedBox(height: 16),


        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: const Icon(Icons.bar_chart, color: Colors.green, size: 32),
            title: const Text("View history"),
            subtitle: const Text("Check light trends and eye care tips."),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryTabView()),
              );
            },
          ),
        ),
      ],
    );
  }
}