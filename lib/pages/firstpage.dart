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
  // pages to push once the bottom navigator tapped
  List<Widget> get _pages => [
    HomeTabView(lux: _lux, advice: getAdvice(_lux)),
    const HistoryTabView(),
    const SettingsTabView(),
  ];


  Light? _light;
  late Stream<int> _lightStream;
  int _lux = 0; //default light value

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog();
    });
    initLightSensor();
  }

// show alert once the login in is successful
  void _showWelcomeDialog() {
    final username = FirebaseAuth.instance.currentUser?.displayName ?? 'User';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hi, $username 👋'),
        content: Text('Welcome to LumoCare Dashboard, \n we are your vision hero.\n'
         'You can check if your ambient light is comfortable.',
        softWrap: true,
        textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }


  void initLightSensor() {
    _light = Light();
    try {
      _lightStream = _light!.lightSensorStream;
      _lightStream.listen((luxValue) {
        setState(() {
          _lux = luxValue;
        });

        final user = FirebaseAuth.instance.currentUser;
        if (user == null) return; // added because uid' can't be unconditionally accessed because the receiver can be 'null'.
        final uid = user.uid;
        final username = user.displayName ?? 'Users';


        final currentHour = DateFormat('H').format(DateTime.now());
        // store the value based on the username- data/hour - light data
        FirebaseFirestore.instance
          .collection('light_data')
          .doc(uid)
          .collection('hourly_data')
          .doc(currentHour)
          .set({
            'username': username,
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
    } else if (lux >= 500 && lux < 1000) {
      return "🔦 The light is good for small delicate task, pay attention to rest";
    } else {
      return "☀️ Strong light, take care of your eyes";
    } 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 215, 205),
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            //Color.fromARGB(255, 142, 171, 162),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
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
                Navigator.pushNamed(context, '/history');
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
                final user = FirebaseAuth.instance.currentUser;
                final username = user?.displayName ?? 'User';
                showDialog(
                  context: context,
                  barrierDismissible: false, // disable tap outer region
                  builder: (context){
                    Future.delayed(const Duration(seconds: 2), () async {
                      Navigator.pop(context); 
                      await FirebaseAuth.instance.signOut(); // sign out
                      Navigator.pushReplacementNamed(context, '/'); // back to welcome page
                    });

                    return AlertDialog(
                      title: Text("Goodbye, $username 👋"),
                      content: const Text("Hope to see you again soon!"),
                    );
                  },
                );
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





  

