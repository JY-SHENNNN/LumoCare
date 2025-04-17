import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'home_tab.dart';
import 'history_tab.dart';
import 'settings_tab.dart';

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
      });
    } catch (e) {
      print("Light sensor error: $e");
    }
  }

  String getAdvice(int lux) {
    if (lux < 100) {
      return "🌙 The light is too weak, turn on the light";
    } else if (lux > 1000) {
      return "☀️ Strong light, take care of your eyes";
    } else {
      return "✅ Moderate light, suitable for eyes, pay attention to rest";
    }
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
                Navigator.pushReplacementNamed(context, 'history');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("S E T T I N G"),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.pushReplacementNamed(context, 'setting');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("L O G O U T"),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'welcome');
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
            Navigator.pop(context); // back to the last page
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





  

