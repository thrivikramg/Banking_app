// lib/customer_detail_screen.dart
import 'package:flutter/material.dart';
import 'customer.dart';
import 'transfer_screen.dart'; // Add this import

class CustomerDetailScreen extends StatelessWidget {
  final Customer customer;

  CustomerDetailScreen({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${customer.name}'),
            Text('Email: ${customer.email}'),
            Text('Balance: \$${customer.currentBalance}'),
            // Add more details as needed
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TransferScreen(sender: customer.name)),
                );
              },
              child: Text('Transfer Money'),
            ),
          ],
        ),
      ),
    );
  }
}
