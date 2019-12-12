import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'accounts.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE accounts(id INTEGER PRIMARY KEY, url TEXT UNIQUE, name TEXT, email TEXT, apiKey TEXT, deviceToken TEXT',
      );
    },
    version: 1,
  );
}

class Account {
  final int id;
  final String name;
  final String email;
  final String apiKey;
  final String deviceToken;
  final String url;

  Account({
    this.id,
    this.name,
    this.email,
    this.apiKey,
    this.deviceToken,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'url': this.url,
      'apiKey': this.apiKey,
      'deviceToken': this.deviceToken,
    };
  }

  static Account fromMap(Map<String, dynamic> map) {
    return Account(
      email: map['email'],
      apiKey: map['apiKey'],
      id: map['id'],
      name: map['name'],
      url: map['url'],
    );
  }
}

Future<void> createAccount(Account account) async {
  final db = await getDatabase();
  await db.insert('accounts', account.toMap());
}

Future<void> deleteAccount(int id) async {
  final db = await getDatabase();
  await db.delete(
    'accounts',
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<void> updateAccount(int id, Account account) async {
  final db = await getDatabase();
  await db.update(
    'accounts',
    account.toMap(),
    where: 'id = ?',
    whereArgs: [id],
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<Account> getAccount(int id) async {
  final db = await getDatabase();
  final data = await db.query(
    'accounts',
    where: 'id = ?',
    whereArgs: [id],
  );
  return Account.fromMap(data.first);
}

Future<List<Account>> getAccounts() async {
  final db = await getDatabase();
  final data = await db.query('accounts');

  return List.generate(data.length, (i) => Account.fromMap(data[i]));
}
