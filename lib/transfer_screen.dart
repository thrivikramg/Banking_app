// lib/transfer_screen.dart
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'transfer.dart';

class TransferScreen extends StatefulWidget {
  final String sender;

  TransferScreen({required this.sender});

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  late TextEditingController _receiverController;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _receiverController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Money'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sender: ${widget.sender}'),
            TextField(
              controller: _receiverController,
              decoration: InputDecoration(labelText: 'Receiver'),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _transferMoney();
              },
              child: Text('Transfer Money'),
            ),
          ],
        ),
      ),
    );
  }

  void _transferMoney() async {
    String receiver = _receiverController.text.trim();
    double amount = double.tryParse(_amountController.text.trim()) ?? 0.0;

    if (receiver.isNotEmpty && amount > 0) {
      Transfer transfer = Transfer(
        sender: widget.sender,
        receiver: receiver,
        amount: amount,
      );

      int result = await DatabaseHelper().transferMoney(transfer);

      if (result == 1) {
        // Successful transfer
        Navigator.popUntil(
            context, (route) => route.isFirst); // Return to the home screen
      } else {
        // Handle failure
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Transfer Failed'),
            content: Text(
                'There was an issue with the money transfer. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Invalid input
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter a valid receiver and amount.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _receiverController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
