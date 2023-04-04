import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'notifications.dart';
import 'dummy.dart';
import 'profile_page.dart'; // assuming this is the file containing the BankCardList screen





class notificationsPage extends StatefulWidget {
  const notificationsPage({Key? key}) : super(key: key);

  @override
  _notificationsPageState createState() => _notificationsPageState();
}
class _notificationsPageState extends State<notificationsPage> {
  List<TransactionData> _transactionData = [    TransactionData(      bankCardName: 'Card 1',      transactionAmount: 100.0,      transactionDate: DateTime.now(),    ),    TransactionData(      bankCardName: 'Card 2',      transactionAmount: 200.0,      transactionDate: DateTime.now(),    ),    TransactionData(      bankCardName: 'You perfomed a transaction to David, 40789743 bank account of \$ ',      transactionAmount: 300.0,      transactionDate: DateTime.now(),    ),    TransactionData(      bankCardName: 'You profile picture was changed at ',      transactionAmount: 01.30,      transactionDate: DateTime.now(),    ),    TransactionData(      bankCardName: 'You perfomed a transaction to Mary, 407847788 bank account of \$ ',      transactionAmount: 300.0,      transactionDate: DateTime.now(),    ),  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: ListView.builder(
          itemCount: _transactionData.length,
          itemBuilder: (context, index) {
            final transaction = _transactionData[index];
            return Card(
              child: ListTile(
                title: Text(transaction.bankCardName),
                subtitle: Text(
                  '${transaction.transactionAmount.toStringAsFixed(2)} - ${transaction.transactionDate.toString()}',
                ),
              ),
            );
          },
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
                      builder: (context) => ProfilePage(
                        email: '',
                        phoneNumber: '',
                        username: '',
                      ),
                    ),
                  );

                  // navigate to profile page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionData {
  final String bankCardName;
  final double transactionAmount;
  final DateTime transactionDate;

  TransactionData({
    required this.bankCardName,
    required this.transactionAmount,
    required this.transactionDate,
  });
}
















