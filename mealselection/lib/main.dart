import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 229, 198),
        appBar: AppBar(
          title: const Text("Meal Selection"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 239, 218, 162),
          elevation: 0,
          leading: Icon(Icons.menu),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // 让内容高度自适应
                  children: [
                    Text(
                      "Don't know what to eat?\nLet me help U",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 20), // 间距
                    Icon(
                      Icons.food_bank_outlined,
                      size: 100,
                    ),
                  ],
                ),
              ),
            ),

            Expanded( 
              child: Container(
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
