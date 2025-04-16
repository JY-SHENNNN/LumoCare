import 'package:flutter/material.dart';

class Firstpage extends StatelessWidget {
  const Firstpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 215, 205),
      appBar: AppBar(
        title: const Text("Light level"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 121, 119, 113),
        elevation: 0,
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
      body: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.wb_sunny, color: Colors.orange, size: 32),
                title: const Text("Current light: 360 lux"),
                subtitle: const Text("✅ Suitable for eye use"),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            ),

            Expanded(
              child: Container(
                color: Colors.grey,
              ),
            ),
          ], 
      ),
    )
    ;
  }
}