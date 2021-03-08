import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:phonebook/core/models/user.dart';

class DatabaseHelper {
  static const _databaseName = 'ContactData.db';
  static const _databaseVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDocDir.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${User.tblUser}(
        ${User.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${User.colEmail} TEXT NOT NULL,
        ${User.colPassword} TEXT NOT NULL
      )
      ''');
  }

  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert(User.tblUser, user.toMap());
  }

  Future<List<User>> fetchContacts() async {
    Database db = await database;
    List<Map> contacts = await db.query(User.tblUser);
    return contacts.length == 0
        ? []
        : contacts.map((x) => User.fromMap(x)).toList();
  }

  Future<bool> isSignedIn(String email, String password) async {
    var dbContact = await database;
    List<Map> maps = await dbContact.query(User.tblUser,
        columns: [User.colPassword],
        where: '${User.colEmail} = ? and ${User.colPassword} = ?',
        whereArgs: [email, password]);
    if (maps.isNotEmpty)
      return true;
    else
      return false;
  }

  Future<bool> uniqueEmail(String email) async {
    Database db = await database;
    List<dynamic> whereargs = [email];
    List<Map> result = await db.query(User.tblUser,
        where: '${User.colEmail} = ?', whereArgs: whereargs);
    Map a = result.firstWhere((element) => element['email'] == email,
        orElse: () => null);
    return (a == null);
  }
}
