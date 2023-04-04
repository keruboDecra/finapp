import 'package:finmate/signup_screen.dart';

import 'home.dart';

import 'dummy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'card.dart';
import 'transactionhistory.dart';





class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;

  final _auth = FirebaseAuth.instance;



  Future<void> signIn() async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // navigate to home page or user profile page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(),
      ));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User not found');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password');
      }
    }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) {
              email = value;
            },
            decoration: InputDecoration(
              hintText: 'Email',
            ),
          ),
          SizedBox(height: 16),
          TextField(
            onChanged: (value) {
              password = value;
            },
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: signIn,
            child: Text('Sign In'),
            ),
          SizedBox(height: 16),

          GestureDetector(
          onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homep(),
          ));
          },
          child: Text(
          'Continue as a guest',
          style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
          ),
          )),

          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage(context: context)),
              );
            },
            child: Text(
              'Dont have an account, Sign Up',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),

          ),
        ],
      ),
    );
  }
}
