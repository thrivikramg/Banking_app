// lib/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'customer.dart';
import 'transfer.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'money_transfer_db';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE customers(
            id INTEGER PRIMARY KEY,
            name TEXT,
            email TEXT,
            current_balance REAL
          )
        ''');

        await db.execute('''
          CREATE TABLE transfers(
            id INTEGER PRIMARY KEY,
            sender TEXT,
            receiver TEXT,
            amount REAL
          )
        ''');

        // Insert 10 dummy data entries
        for (int i = 1; i <= 10; i++) {
          await db.insert(
            'customers',
            Customer(
              name: 'Customer $i',
              email: 'customer$i@example.com',
              currentBalance: 1000.0, // Initial balance
            ).toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      },
    );
  }

  Future<int> transferMoney(Transfer transfer) async {
    final Database db = await database;

    // Begin a transaction
    await db.transaction((txn) async {
      // Insert transfer record
      await txn.insert('transfers', transfer.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);

      // Update sender's balance
      await txn.rawUpdate(
        'UPDATE customers SET current_balance = current_balance - ? WHERE name = ?',
        [transfer.amount, transfer.sender],
      );

      // Update receiver's balance
      await txn.rawUpdate(
        'UPDATE customers SET current_balance = current_balance + ? WHERE name = ?',
        [transfer.amount, transfer.receiver],
      );
    });

    return 1; // Success
  }

  Future<List<Customer>> getAllCustomers() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('customers');
    return List.generate(maps.length, (i) {
      return Customer(
        name: maps[i]['name'],
        email: maps[i]['email'],
        currentBalance: (maps[i]['current_balance'] as num).toDouble(),
      );
    });
  }
}
