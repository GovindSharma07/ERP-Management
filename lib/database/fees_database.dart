import 'dart:convert';

import 'package:erp_management/model/fees_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:erp_management/extra/constants.dart' as constants;
import 'package:http/http.dart' as http;

class FeesDatabaseHelper {
  FeesDatabaseHelper._() {
    initializeFeesDatabase();
  }

  static final FeesDatabaseHelper _instance = FeesDatabaseHelper._();

  factory FeesDatabaseHelper() {
    return _instance;
  }

  static Database? _database;

  Future<void> initializeFeesDatabase() async {
    if (_database == null) {
      sqfliteFfiInit();
      final dbFactory = databaseFactoryFfi;
      final documentsDir = await getApplicationDocumentsDirectory();
      final dbPath = path.join(documentsDir.path, 'fees.db');
      _database = await dbFactory.openDatabase(dbPath);
      await _database?.execute(
          "CREATE TABLE IF NOT EXISTS fees (id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "uid TEXT NOT NULL,"
          "amount INTEGER NOT NULL,"
          "slipNumber TEXT NOT NULL,"
          "date DATE NOT NULL)");
    }
  }

  Future<void> addFeesDetails(FeesModel feesModel) async {
    await _database?.insert("fees", feesModel.toJson());
    var url = Uri.parse(constants.addFeesDetails);
    await http.post(url,
    headers: {"Content-Type": "application/json"}, body: jsonEncode(feesModel.toJson()));
  }
}
