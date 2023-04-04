import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() => runApp(const MyApp());
final FirebaseFirestore _db = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Cards',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BankCardList(),
    );
  }
}

class BankCard {
  final String bankName;
  final String accountNumber;
  final String routingNumber;
  final String idNumber;

  BankCard({
    required this.bankName,
    required this.accountNumber,
    required this.routingNumber,
    required this.idNumber,
  });
}

class BankCardList extends StatefulWidget {
  const BankCardList({Key? key}) : super(key: key);

  @override
  _BankCardListState createState() => _BankCardListState();

  List<BankCard> get bankCards => _BankCardListState()._bankCards;
}



  class _BankCardListState extends State<BankCardList> {
  final List<BankCard> _bankCards = [];

  @override
  void initState() {
  super.initState();
  _fetchBankCards();
  }

  Future<void> _fetchBankCards() async {
  final currentUser = _auth.currentUser!;
  final userRef = _db.collection('users').doc(currentUser.uid);

  final bankCardsSnapshot = await userRef.collection('bankCards').get();

  final bankCards = bankCardsSnapshot.docs.map((doc) {
  final data = doc.data();
  return BankCard(
  bankName: data['bankName'],
  accountNumber: data['accountNumber'],
  routingNumber: data['routingNumber'],
  idNumber: data['idNumber'],
  );
  }).toList();

  setState(() {
  _bankCards.clear();
  _bankCards.addAll(bankCards);
  });
  }


  void _addBankCardToFirestore(BankCard newCard) async {
    final currentUser = _auth.currentUser!;
    final userRef = _db.collection('users').doc(currentUser.uid);

    final data = {
      'bankName': newCard.bankName,
      'accountNumber': newCard.accountNumber,
      'routingNumber': newCard.routingNumber,
      'idNumber': newCard.idNumber,
    };

    await userRef.collection('bankCards').add(data);
  }




  void _addBankCard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddBankCard(),
      ),
    ).then((newCard) {
      if (newCard != null) {
        setState(() {
          _bankCards.add(newCard);
          _addBankCardToFirestore(newCard); // add card to Firestore
        });
      }
    });
  }




  void _editBankCard(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBankCard(bankCard: _bankCards[index]),
      ),
    ).then((editedCard) {
      if (editedCard != null) {
        setState(() {
          _bankCards[index] = editedCard;
          _updateBankCardInFirestore(index, editedCard); // update card in Firestore
        });
      }
    });
  }

  Future<void> _updateBankCardInFirestore(int index, BankCard bankCard) async {
    final currentUser = _auth.currentUser!;
    final userRef = _db.collection('users').doc(currentUser.uid);

    final docSnapshot =
    await userRef.collection('bankCards').get().then((snapshot) => snapshot.docs[index]);

    if (docSnapshot.exists) {
      final docRef = docSnapshot.reference;

      final data = {
        'bankName': bankCard.bankName,
        'accountNumber': bankCard.accountNumber,
        'routingNumber': bankCard.routingNumber,
        'idNumber': bankCard.idNumber,
      };

      await docRef.update(data);
    }
  }

  void _deleteBankCard(int index) async {
    final currentUser = _auth.currentUser!;
    final userRef = _db.collection('users').doc(currentUser.uid);

    final docSnapshot =
    await userRef.collection('bankCards').get().then((snapshot) => snapshot.docs[index]);

    if (docSnapshot.exists) {
      final docRef = docSnapshot.reference;

      await docRef.delete();
    }

    setState(() {
      _bankCards.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Cards'),
      ),
      body: ListView.builder(
        itemCount: _bankCards.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_bankCards[index].bankName),
            subtitle: Text(
                'Account: ${_bankCards[index].accountNumber} Routing: ${_bankCards[index].routingNumber}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editBankCard(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteBankCard(index),
                ),
              ],
            ),
          );
        },


      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBankCard,
        tooltip: 'Add New Card',
        child: const Icon(Icons.add),
      ),


    );

  }

}



class AddBankCard extends StatefulWidget {
  const AddBankCard({Key? key}) : super(key: key);

  @override
  _AddBankCardState createState() => _AddBankCardState();
}

class _AddBankCardState extends State<AddBankCard> {
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _accountNumberController = TextEditingController();
  TextEditingController _routingNumberController = TextEditingController();
  TextEditingController _idNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bank Card'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _bankNameController,
              decoration: InputDecoration(
                labelText: 'Bank Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _accountNumberController,
              decoration: InputDecoration(
                labelText: 'Account Number',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _routingNumberController,
              decoration: InputDecoration(
                labelText: 'Routing Number',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final newBankCard = BankCard(
                  bankName: _bankNameController.text,
                  accountNumber: _accountNumberController.text,
                  routingNumber: _routingNumberController.text,
                  idNumber: _idNumberController.text,
                );

                Navigator.pop(context, newBankCard);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _routingNumberController.dispose();
    _idNumberController.dispose();

    super.dispose();
  }
}



class EditBankCard extends StatefulWidget {
  final BankCard bankCard;

  const EditBankCard({Key? key, required this.bankCard}) : super(key: key);

  @override
  _EditBankCardState createState() => _EditBankCardState();
}





class _EditBankCardState extends State<EditBankCard> {
  late final TextEditingController _bankNameController;
  late final TextEditingController _accountNumberController;
  late final TextEditingController _routingNumberController;
  late final TextEditingController _idNumberController;

  @override
  void initState() {
    super.initState();
    _bankNameController = TextEditingController(text: widget.bankCard.bankName);
    _accountNumberController =
        TextEditingController(text: widget.bankCard.accountNumber);
    _routingNumberController =
        TextEditingController(text: widget.bankCard.routingNumber);

    _idNumberController = TextEditingController(text: widget.bankCard.idNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Bank Card'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _bankNameController,
              decoration: InputDecoration(
                labelText: 'Bank Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _accountNumberController,
              decoration: InputDecoration(
                labelText: 'Account Number',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _routingNumberController,
              decoration: InputDecoration(
                labelText: 'Routing Number',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final editedBankCard = BankCard(
                  bankName: _bankNameController.text,
                  accountNumber: _accountNumberController.text,
                  routingNumber: _routingNumberController.text,
                  idNumber: _idNumberController.text,
                );

                Navigator.pop(context, editedBankCard);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }





  @override
  void dispose() {
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _routingNumberController.dispose();
    _idNumberController.dispose();

    super.dispose();
  }
}
