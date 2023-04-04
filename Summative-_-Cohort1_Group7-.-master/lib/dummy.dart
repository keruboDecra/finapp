import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'login_screen.dart';

import 'signup_screen.dart';
import 'notifications.dart';
import 'card.dart'; // assuming this is the file containing the BankCardList screen
import 'transactions.dart'; // assuming this is the file containing the BankCardList screen
import 'transactionhistory.dart';
import 'profile_page.dart'; // assuming this is the file containing the BankCardList screen






class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
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

          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 9),
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
                        child: Column(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BankCardList()),
                              );
                            },
                            child: Image(
                              image: AssetImage("assets/cardicon.png"),
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                        SizedBox(width: 7), // add some space between the image and the label
                        Text(
                          "Cards",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionHistoryPage()),
                    );
                    // navigate to contacts page
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionHistoryPage()),
                    );
                  },
                  // navigate to transfers page

                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactionPage()),
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
                'Today',
                style: TextStyle(fontSize: 24),
              ),
            ),



            Card(
              margin: EdgeInsets.all(16),
              child: ListTile(
                leading: Icon(Icons.payment),
                title: Text('You received payment'),
                subtitle: Text('\$50\nAmmy Silver'),
              ),
            ),



            Card(
              margin: EdgeInsets.all(16),
              child: ListTile(
                leading: Icon(Icons.payment),
                title: Text('You received payment'),
                subtitle: Text('\$100\nAmmy Silver'),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16),
              child: ListTile(
                leading: Icon(Icons.payment),
                title: Text('You received payment'),
                subtitle: Text('\$900\nAmmy Silver'),
              ),
            ),


          ],
        ),
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
                  MaterialPageRoute(
                      builder: (context) => HomePage()),
                );
                // navigate to card-related page
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => notificationsPage()),
                );
              },
            ),
            IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(email: '',phoneNumber: '',username: '',),
                    ),
                  );
// navigate to profile page
                }),
          ],
        ),
      ),




    );
  }
}













