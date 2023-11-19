// lib/models/transfer.dart
class Transfer {
  final String sender;
  final String receiver;
  final double amount;

  Transfer({
    required this.sender,
    required this.receiver,
    required this.amount,
  });

  // Convert Transfer object to a Map
  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'receiver': receiver,
      'amount': amount,
    };
  }
}
