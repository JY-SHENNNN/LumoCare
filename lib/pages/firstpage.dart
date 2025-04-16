import 'package:flutter/material.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeTabView(),
    const HistoryTabView(),
    const SettingsTabView(),
  ];

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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("S E T T I N G"),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("L O G O U T"),
              onTap: () {
                
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

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: const ListTile(
            leading: Icon(Icons.wb_sunny, color: Colors.orange, size: 32),
            title: Text("Current light: 360 lux"),
            subtitle: Text("✅ Suitable for eye use"),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: const ListTile(
            leading: Icon(Icons.remove_red_eye, color: Colors.blue, size: 32),
            title: Text("Advice"),
            subtitle: Text("Bright enough.\nRemember to take breaks."),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: const ListTile(
            leading: Icon(Icons.bar_chart, color: Colors.green, size: 32),
            title: Text("View history"),
            subtitle: Text("Check light trends and eye care tips."),
          ),
        ),
      ],
    );
  }
}

class HistoryTabView extends StatelessWidget {
  const HistoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("📈 Light history chart here"));
  }
}
  
class SettingsTabView extends StatelessWidget {
  const SettingsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: const Text("Enable light monitoring"),
        ),
        SwitchListTile(
          value: false,
          onChanged: (val) {},
          title: const Text("Upload data to cloud"),
        ),
        const Divider(),
        ListTile(
          title: const Text("Change Password"),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Logout"),
          onTap: () {},
        ),
      ],
    );
  }
}
