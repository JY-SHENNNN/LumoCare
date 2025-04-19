import 'package:flutter/material.dart';

class SettingsTabView extends StatefulWidget {
  const SettingsTabView({super.key});

  @override
  State<SettingsTabView> createState() => _SettingsTabViewState();
}


class _SettingsTabViewState extends State<SettingsTabView> {
bool _isMonitoringEnabled = true;
bool _isUploadEnabled = true;

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
            value: _isMonitoringEnabled,
            onChanged: (val) {
              setState(() {
                _isMonitoringEnabled = val;
              }
              );
            },
            title: const Text("Enable light monitoring"),
          ),
          SwitchListTile(
            value: _isUploadEnabled,
            onChanged: (val) {
              setState(() {
                _isUploadEnabled = val;
              });
            },
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
              Navigator.pushReplacementNamed(context, '/'); 
            },
          ),
        ],
      ),
    );
  }
}

