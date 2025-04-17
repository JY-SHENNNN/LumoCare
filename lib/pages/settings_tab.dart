import 'package:flutter/material.dart';

class SettingsTabView extends StatelessWidget {
  const SettingsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.grey[800],
      ),
      body: ListView(
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
            onTap: () {
              Navigator.pushReplacementNamed(context, 'welcome'); 
            },
          ),
        ],
      ),
    );
  }
}
