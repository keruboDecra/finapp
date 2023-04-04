import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dummy.dart';
import 'notifications.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String username;
  final String phoneNumber;

  ProfilePage({
    required this.email,
    required this.username,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Image.asset('assets/profile.png', fit: BoxFit.cover),
          ),
          Card(
            margin: EdgeInsets.all(16),
            child: ListTile(
              title: Text('Email'),
              subtitle: Text(email),
              leading: Icon(Icons.email),
            ),
          ),
          Card(
            margin: EdgeInsets.all(16),
            child: ListTile(
              title: Text('Username'),
              subtitle: Text(username),
              leading: Icon(Icons.person),
            ),
          ),
          Card(
            margin: EdgeInsets.all(16),
            child: ListTile(
              title: Text('Phone Number'),
              subtitle: Text(phoneNumber),
              leading: Icon(Icons.phone),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.credit_card),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => notificationsPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(
                    email: email,
                    username: username,
                    phoneNumber: phoneNumber,
                  )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
