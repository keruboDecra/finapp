
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:finmate/login_screen.dart';
import 'profile_page.dart';
import 'signup_screen.dart';



class Homep extends StatefulWidget {
  const Homep({Key? key}) : super(key: key);

  @override
  State<Homep> createState() => _HomepState();
}

class _HomepState extends State<Homep> {
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;
  @override


  Widget _buildSlide(String image, String title, String description) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('image.png'),
          SizedBox(height: 7.0),
          Text(
            'Title',
            style: TextStyle(fontSize: 4.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Description',
            textAlign: TextAlign.center,
          ),
        ],
      )

    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white, // Add this line to make app bar white
          leading:Image(image: AssetImage("assets/background.png" ), height: 40,
              width: 40),
          title: Text(
            'FinMate',
            style: TextStyle(
              color: Colors.black,
            ),
          ),


          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 14),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                primary: Colors.white, // button background color
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.blue, // text color
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),


            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("You have to login to perform any activity. Log in here."),
                      actions: [

                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => LoginPage(),
                              ),
                            ); // Navigate to SignInPage
                          },
                          child: Text("Log In"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],

        ),






        body: Column(        children: [

              SizedBox(width: 300),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: AssetImage("assets/card2.png"),
                            height: 180,
                            width: 240,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Card(
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('You are required to sign in.'),
                                    duration: Duration(seconds: 4),
                                  ),
                                );
                              },
                              child: Image(
                                image: AssetImage("assets/cardicon.png"),
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),
                          SizedBox(width: 7), // add some space between the image and the label
                          Text(
                            "Cards",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You are required to sign in.'),
                          duration: Duration(seconds: 4),
                        ),
                      );

                    },
                    child: Column(
                      children: [
                        Icon(Icons.contacts),
                        SizedBox(height: 8),
                        Text('Your Transactions'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You are required to sign in.'),
                          duration: Duration(seconds: 4),
                        ),
                      );

                    },
                    // navigate to transfers page

                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('You are required to sign in.'),
                                duration: Duration(seconds: 4),
                              ),
                            );

                          },
                          child: Column(
                            children: [
                              Icon(Icons.attach_money),
                              SizedBox(height: 8),
                              Text('Transfer Money'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Why FinMate',
                  style: TextStyle(fontSize: 24),
                ),
              ),

              Container(

                height: 250,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(width: 90),
                    Column(
                      children: [
                        Image(
                          image: AssetImage("assets/service.png"),
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Excellent Service",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(width: 90),
                    Column(
                      children: [
                        Image(
                          image: AssetImage("assets/phone.png"),
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Global Peer-To-Peer Transactions",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(width: 90),
                    Column(
                      children: [
                        Image(
                          image: AssetImage("assets/security.png"),
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Guaranteed Security",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SignUpPage(context: context,)),
                  );
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: BorderSide(color: Colors.white),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Center(
                  child: SizedBox(
                  width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpPage(context: context)),
                          );
                        },
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ),
                  ),
                ),

                Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),






            ]));





  }
}













