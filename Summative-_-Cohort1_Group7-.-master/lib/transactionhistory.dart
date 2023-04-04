import 'package:flutter/material.dart';

import 'dummy.dart';
import 'notifications.dart';
import 'profile_page.dart'; // assuming this is the file containing the BankCardList screen


class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  List<TransactionData> _transactionData = [
    TransactionData(
      bankCardName: 'Card 1',
      transactionAmount: 100.0,
      transactionDate: DateTime.now(),
    ),
    TransactionData(
      bankCardName: 'Card 2',
      transactionAmount: 200.0,
      transactionDate: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: ListView.builder(
        itemCount: _transactionData.length,
        itemBuilder: (context, index) {
          final transaction = _transactionData[index];
          return ListTile(
            title: Text(transaction.bankCardName),
            subtitle: Text(
                '${transaction.transactionAmount.toStringAsFixed(2)} - ${transaction.transactionDate.toString()}'),
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
