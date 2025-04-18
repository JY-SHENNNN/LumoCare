import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'home_tab.dart';
import 'history_tab.dart';
import 'settings_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
  HomeTabView(lux: _lux, advice: getAdvice(_lux)),
  const HistoryTabView(),
  const SettingsTabView(),
];


  Light? _light;
  late Stream<int> _lightStream;
  int _lux = 0;

  @override
  void initState() {
    super.initState();
    initLightSensor();
  }

  void initLightSensor() {
    _light = Light();
    try {
      _lightStream = _light!.lightSensorStream;
      _lightStream.listen((luxValue) {
        setState(() {
          _lux = luxValue;
        });

        final currentHour = DateFormat('H').format(DateTime.now());
        FirebaseFirestore.instance.collection('light_data').doc(currentHour).set({
          'lux': luxValue,
          'timestamp': FieldValue.serverTimestamp(),
        });
      });
    } catch (e) {
      print("Light sensor error: $e");
    }
  }

  String getAdvice(int lux) {
    if (lux < 100) {
      return "🌙 The light is too weak, turn on the light";
    } else if (lux >= 100 && lux < 300){
      return "🕯️ The light is good for relax";
    } else if (lux >= 300 && lux < 500){
      return "💡 The light is good for study or work, pay attention to rest";
    } else {
      return "🔦 The light is good for small delicate task, pay attention to rest";
    } 
    // else {
    //   return "☀️ Strong light, take care of your eyes";
    // } 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 215, 205),
      appBar: AppBar(
        title: const Text("LumoCare Dashboard"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 121, 119, 113),
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 207, 203, 192),
        child: Column(
          children: [
            const DrawerHeader(
              child: Icon(Icons.account_balance, size: 80),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("H O M E"),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("H I S T O R Y"),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.pushNamed(context, 'history');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("S E T T I N G"),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.pushNamed(context, '/setting');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("L O G O U T"),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),

          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 121, 119, 113),
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) { // if tab return icon
            Navigator.pushNamed(context, '/dashboard'); // back to the last page
          } else {
            setState(() {
              _currentIndex = index; // back to normal page
            });
          }
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: "Back"),
        ],
      ),
    );
  }
}





  

