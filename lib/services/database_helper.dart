import 'dart:async';
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:path/path.dart';
import '../models/account.dart';
import '../models/category.dart';
import '../models/transaction.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'finance.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        balance REAL
      )
    ''');
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL,
        type TEXT,
        categoryId INTEGER,
        accountId INTEGER,
        date TEXT,
        description TEXT,
        FOREIGN KEY (categoryId) REFERENCES categories(id),
        FOREIGN KEY (accountId) REFERENCES accounts(id)
      )
    ''');

    // Seed initial data
    await db.insert('accounts', {'name': 'Cash', 'balance': 0.0});
    await db.insert('accounts', {'name': 'Bank Account', 'balance': 0.0});
    await db.insert('accounts', {'name': 'Card', 'balance': 0.0});
    await db.insert('categories', {'name': 'Food'});
    await db.insert('categories', {'name': 'Salary'});
  }

  Future<List<Account>> getAccounts() async {
    final db = await database;
    final maps = await db.query('accounts');
    return maps.map((map) => Account.fromMap(map)).toList();
  }

  Future<List<Category>> getCategories() async {
    final db = await database;
    final maps = await db.query('categories');
    return maps.map((map) => Category.fromMap(map)).toList();
  }

  Future<List<Transaction>> getTransactions({int? accountId, DateTime? startDate, DateTime? endDate}) async {
    final db = await database;
    String where = '';
    List<dynamic> args = [];
    if (accountId != null) {
      where += 'accountId = ?';
      args.add(accountId);
    }
    if (startDate != null && endDate != null) {
      where += where.isNotEmpty ? ' AND date BETWEEN ? AND ?' : 'date BETWEEN ? AND ?';
      args.add(startDate.toIso8601String());
      args.add(endDate.toIso8601String());
    }
    final maps = await db.query(
      'transactions',
      where: where.isEmpty ? null : where,
      whereArgs: args.isEmpty ? null : args,
    );
    return maps.map((map) => Transaction.fromMap(map)).toList();
  }

  Future<void> addTransaction(Transaction transaction) async {
    final db = await database;
    await db.insert('transactions', transaction.toMap());
    // Update account balance
    final account = await db.query('accounts', where: 'id = ?', whereArgs: [transaction.accountId]);
    if (account.isNotEmpty) {
      double newBalance = account.first['balance'] as double;
      newBalance += transaction.type == 'income' ? transaction.amount : -transaction.amount;
      await db.update('accounts', {'balance': newBalance}, where: 'id = ?', whereArgs: [transaction.accountId]);
    }
  }

  Future<void> insertAccount(Account account) async {
  final db = await database;
  await db.insert('accounts', account.toMap());
}

Future<void> deleteAccount(int id) async {
  final db = await database;
  await db.delete('accounts', where: 'id = ?', whereArgs: [id]);
}
}
