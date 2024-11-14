import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'activities.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE activities(
          id TEXT PRIMARY KEY,
          type TEXT, 
          name TEXT, 
          icon TEXT, 
          dateCreated TEXT, 
          amount INTEGER, 
          status TEXT
          );
          ''');
        await db.execute('''
          CREATE TABLE company (
              id TEXT PRIMARY KEY,
              companyName TEXT NOT NULL,
              accountId TEXT,
              legalName TEXT NOT NULL,
              registrationNumber TEXT NOT NULL,
              companyType TEXT NOT NULL,
              email TEXT NOT NULL,
              phone TEXT,
              mobileNumber TEXT,
              faxNumber TEXT,
              companyAddress_street TEXT,
              companyAddress_city TEXT,
              companyAddress_state TEXT,
              companyAddress_postalCode TEXT,
              customerFacingAddress_street TEXT,
              customerFacingAddress_city TEXT,
              customerFacingAddress_state TEXT,
              customerFacingAddress_postalCode TEXT,
              legalAddress_street TEXT,
              legalAddress_city TEXT,
              legalAddress_state TEXT,
              legalAddress_postalCode TEXT,
              website TEXT,
              storesId TEXT, -- Comma-separated list for stores ID
              staff TEXT, -- Comma-separated list for staff
              latitude REAL NOT NULL,
              longitude REAL NOT NULL,
              companyLogo TEXT,
              createdAt TEXT NOT NULL, -- Store as ISO 8601 string
              updatedAt TEXT NOT NULL  -- Store as ISO 8601 string
              );
        ''');
        await db.execute('''
            CREATE TABLE expense (
              id TEXT PRIMARY KEY,
              payee TEXT NOT NULL,
              paymentAccount TEXT,
              paymentDate TEXT NOT NULL, -- Store as ISO 8601 string
              dueDate TEXT NOT NULL, -- Store as ISO 8601 string
              paymentMethod TEXT,
              referenceNo TEXT,
              permitNo TEXT,
              expenseStatus TEXT NOT NULL,
              categoryItems TEXT, -- Comma-separated list for category items
              productItems TEXT, -- Comma-separated list for product items
              totalAmount INTEGER NOT NULL,
              memo TEXT,
              attachments TEXT, -- Comma-separated list for attachments
              currencyType TEXT NOT NULL,
              createdAt TEXT NOT NULL, -- Store as ISO 8601 string
              updatedAt TEXT NOT NULL  -- Store as ISO 8601 string
              );
        ''');
        await db.execute('''
            CREATE TABLE vendors (
                id TEXT PRIMARY KEY,
                companyName TEXT NOT NULL,
                vendorDisplayName TEXT,
                title TEXT,
                firstName TEXT,
                middleName TEXT,
                lastName TEXT,
                displayName TEXT,
                suffix TEXT,
                email TEXT,
                phone TEXT,
                mobileNumber TEXT,
                faxNumber TEXT,
                address TEXT, -- Assuming address is stored as a text representation
                nameOnChecks TEXT,
                accountName TEXT,
                accountNo TEXT,
                routingNo TEXT,
                businessIdNo TEXT,
                website TEXT,
                openingBalance REAL,
                notes TEXT,
                createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
                updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
                  );
          ''');

        await db.execute('''
              CREATE TABLE staff (
                  id TEXT PRIMARY KEY,
                  firstName TEXT NOT NULL,
                  lastName TEXT NOT NULL,
                  email TEXT,
                  phone TEXT,
                  gender TEXT,
                  birthdate DATETIME,
                  role TEXT,
                  department TEXT,
                  companyId TEXT NOT NULL,
                  storeId TEXT, -- Consider storing as a comma-separated string or using a separate table for many-to-many relationships
                  address TEXT, -- Assuming address is stored as a text representation
                  imageUrl TEXT,
                  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
                  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
                );
          ''');
      },
    );
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> fetchAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> data, String where,
      List<dynamic> whereArgs) async {
    final db = await database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
      String table, String where, List<dynamic> whereArgs) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }
}
