import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        backgroundColor: Color.fromARGB(255, 121, 119, 113),
      ),
      body: Container(
        color: const Color.fromARGB(255, 207, 203, 192),
        child: ListView(
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
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final TextEditingController _passwordController = TextEditingController();

                    return AlertDialog(
                      title: const Text("Change Password"),
                      content: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'New Password',
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        ElevatedButton(
                          child: const Text("Update"),
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance.currentUser!
                                  .updatePassword(_passwordController.text.trim());
                              Navigator.pushNamed(context,'/');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Password updated successfully!")),
                              );
                            } catch (e) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: ${e.toString()}")),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/'); 
              },
            ),
          ],
        ),
      ),
      
    );
  }
}

