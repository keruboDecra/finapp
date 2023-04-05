import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dummy.dart';
import 'notifications.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _email = '';
  String _username = '';
  String _phoneNumber = '';







  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      // Initialize Firebase if it hasn't been initialized yet
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      // Get the currently signed-in user's UID
      final uid = FirebaseAuth.instance.currentUser!.uid;

      // Query the Firestore collection for the user's document
      final snapshot = await _firestore.collection('users').doc(uid).get();

      // Get the email, username, and phone number fields from the document
      final data = snapshot.data()!;
      _email = data['email'];
      _username = data['username'];
      _phoneNumber = data['phoneNumber'];

      // Update the UI with the retrieved data
      setState(() {});
    } catch (e) {
      // Handle any errors
      print(e.toString());
    }
  }





























  @override
  Widget build(BuildContext context) {
    return Scaffold(


        appBar: AppBar(
          backgroundColor: Colors.blue, // Add this line to make app bar white
          title: Text(
            'Welcome to your Profile Page',
            style: TextStyle(

              color: Colors.white,
            ),
          ),

          actions: [

            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirm Log Out"),
                      content: Text("Are you sure you want to log out?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>  LoginPage(),
                              ),
                            ); // Navigate to SignInPage
                          },
                          child: Text("Log Out"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: _email == null || _username == null || _phoneNumber == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(height: 30),

              Center(
                child: Stack(children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:  AssetImage("assets/profile3.png"),


                    )),
                  ),

                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Colors.white,
                            ),
                            color: Colors.blue),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )),

                ])),

              SizedBox(height: 30),

              Divider(
                height: 4,
                thickness: 2,
                indent: 20,
                endIndent: 0,
                color: Colors.grey.withOpacity(0.4),
              ),

              Ink(
                color: Colors.blue.withOpacity(0.05),

                child: Card(
                  margin: EdgeInsets.all(16),
                  child: ListTile(
                    title: Text('Email'),
                    subtitle: Text(_email),
                    leading: Icon(Icons.email),
                  ),
                ),
              ),
              Divider(
                height: 4,
                thickness: 2,
                indent: 20,
                endIndent: 0,
                color: Colors.grey.withOpacity(0.4),
              ),
              Ink(
                color: Colors.blue.withOpacity(0.05),

                child: Card(
                  margin: EdgeInsets.all(16),
                  child: ListTile(
                    title: Text('Username'),
                    subtitle: Text(_username),
                    leading: Icon(Icons.person),
                  ),
                ),
              ),
              Divider(
                height: 4,
                thickness: 2,
                indent: 20,
                endIndent: 0,
                color: Colors.grey.withOpacity(0.4),
              ),
              Ink(
                color: Colors.blue.withOpacity(0.05),

                child: Card(
                  margin: EdgeInsets.all(16),
                  child: ListTile(
                    title: Text('Phone Number'),
                    subtitle: Text(_phoneNumber),
                    leading: Icon(Icons.phone),
                  ),
                ),
              ),

              Center(
                child: Stack(children: [
                  Container(
                    child: Lottie.network(
                      'https://assets7.lottiefiles.com/packages/lf20_fN91t3YtTf.json',
                      height: 220,
                      width: 500,
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),


        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home),
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
                  // Refresh user data before navigating to profile page again
                  _fetchUserData();
                },
              ),
            ],
          ),)
    );
  }
}



