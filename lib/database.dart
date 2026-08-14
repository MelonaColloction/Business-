import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models.dart';

class AppDatabase {
  AppDatabase._();
  static final instance = AppDatabase._();
  Database? _db;

  Future<void> init() async {
    final path = join(await getDatabasesPath(), 'business_manager.db');
    _db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE transactions(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          type TEXT NOT NULL, amount REAL NOT NULL, category TEXT NOT NULL,
          note TEXT, date TEXT NOT NULL, contact TEXT, payment_method TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE contacts(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL, phone TEXT, role TEXT, note TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE appointments(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL, contact TEXT, date TEXT NOT NULL, time TEXT NOT NULL,
          amount REAL NOT NULL, status TEXT, note TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE products(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL, kind TEXT, buy_price REAL NOT NULL,
          sell_price REAL NOT NULL, stock REAL NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE settings(
          key TEXT PRIMARY KEY, value TEXT NOT NULL
        )
      ''');
    });
  }

  Database get db => _db!;

  Future<int> addTransaction(TransactionItem item) =>
      db.insert('transactions', item.toMap()..remove('id'));

  Future<List<TransactionItem>> transactions() async {
    final rows = await db.query('transactions', orderBy: 'date DESC, id DESC');
    return rows.map(TransactionItem.fromMap).toList();
  }

  Future<int> deleteTransaction(int id) =>
      db.delete('transactions', where: 'id=?', whereArgs: [id]);

  Future<int> addContact(ContactItem item) =>
      db.insert('contacts', item.toMap()..remove('id'));

  Future<List<ContactItem>> contacts() async {
    final rows = await db.query('contacts', orderBy: 'id DESC');
    return rows.map(ContactItem.fromMap).toList();
  }

  Future<int> deleteContact(int id) =>
      db.delete('contacts', where: 'id=?', whereArgs: [id]);

  Future<int> addAppointment(AppointmentItem item) =>
      db.insert('appointments', item.toMap()..remove('id'));

  Future<List<AppointmentItem>> appointments() async {
    final rows = await db.query('appointments', orderBy: 'date ASC, time ASC');
    return rows.map(AppointmentItem.fromMap).toList();
  }

  Future<int> deleteAppointment(int id) =>
      db.delete('appointments', where: 'id=?', whereArgs: [id]);

  Future<int> addProduct(ProductItem item) =>
      db.insert('products', item.toMap()..remove('id'));

  Future<List<ProductItem>> products() async {
    final rows = await db.query('products', orderBy: 'id DESC');
    return rows.map(ProductItem.fromMap).toList();
  }

  Future<int> deleteProduct(int id) =>
      db.delete('products', where: 'id=?', whereArgs: [id]);

  Future<void> setSetting(String key, String value) async {
    await db.insert('settings', {'key': key, 'value': value},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getSetting(String key) async {
    final rows = await db.query('settings', where: 'key=?', whereArgs: [key]);
    return rows.isEmpty ? null : rows.first['value'] as String;
  }
}
