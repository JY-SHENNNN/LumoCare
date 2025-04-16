import 'package:flutter/material.dart';
import 'package:testapp/pages/firstpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(), 
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 215, 205),
      appBar: AppBar(
        title: const Text("LumoCare"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 121, 119, 113),
        elevation: 0,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.menu),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.account_balance,
              ),
            ),
            //HOME PAGE LIST TITLE
            ListTile(
              leading: Icon(Icons.home),
              title: Text("H O M E"),
              onTap: () {
                // go to home page
              },
            ),

            //SETTING PAGE LIST TITLE
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("S E T T I N G"),
              onTap:() {
                // go to setting page
              },
            ),

            //LOG OUT PAGE LIST TITLE
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("L O G O U T"),
              onTap:() {
                // go to welcome page
              },
            )
          ], 
        ),
      ),
      
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Smart light monitoring,\nbe your vision hero",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 40),

              // 🌞 Real-time monitoring
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.wb_sunny, size: 30, color: Colors.white),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      "Real-time monitoring\nof environmental light",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 👁️ Low light reminders
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.remove_red_eye, size: 30, color: Colors.white),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      "Low light reminders\nStrong light suggestions",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ☁️ Data recording
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.cloud, size: 30, color: Colors.white),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      "Record your eye-use\nenvironmental data",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              const Text(
                "Access to your light sensor is required for \n proper operation",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Firstpage(),),);
                },
                child: const Text(
                  "ALLOW ACCESS",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "MAYBE LATER",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
