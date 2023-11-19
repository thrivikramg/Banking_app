// lib/customer.dart
class Customer {
  final String name;
  final String email;
  final double currentBalance;

  Customer({
    required this.name,
    required this.email,
    required this.currentBalance,
  });

  // Convert Customer object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'current_balance': currentBalance,
    };
  }
}
