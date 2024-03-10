import 'dart:convert';

import 'package:erp_management/model/student_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:erp_management/extra/constants.dart' as constants;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class UsersDatabaseHelper {
  UsersDatabaseHelper._() {
    _initializeUsersDatabase();
  }

  static final UsersDatabaseHelper _instance = UsersDatabaseHelper._();

  factory UsersDatabaseHelper() {
    return _instance;
  }

  static Database? _database;

  Future<void> _initializeUsersDatabase() async {
    if (_database == null) {
      sqfliteFfiInit();
      final dbFactory = databaseFactoryFfi;
      final documentsDir = await getApplicationDocumentsDirectory();
      final dbPath = path.join(documentsDir.path, 'users.db');
      _database = await dbFactory.openDatabase(dbPath);
      await _database?.execute("CREATE TABLE IF NOT EXISTS students ("
          "uid TEXT NOT NULL PRIMARY KEY,"
          "email TEXT NOT NULL,"
          "fName TEXT NOT NULL,"
          "lName TEXT NOT NULL,"
          "rollNo TEXT NOT NULL,"
          "dateOfBirth TEXT NOT NULL,"
          "gender TEXT NOT NULL,"
          "annualFees TEXT NOT NULL,"
          "feesPaid TEXT NOT NULL,"
          "busAllocated TEXT NOT NULL,"
          "studentContact TEXT NOT NULL,"
          "parentContact TEXT NOT NULL,"
          "address TEXT NOT NULL,"
          "course TEXT NOT NULL,"
          "section TEXT NOT NULL)");
    }
  }

  Future<void> addStudentDetails(StudentModel studentModel) async {
    if ((await _database?.rawQuery(
            "SELECT uid FROM students WHERE uid = ?", [studentModel.uid]))!
        .isEmpty) {
      await _database?.insert("students", studentModel.toJson());
    } else {
      await _database?.update("students", studentModel.toJson(),
          where: "uid = ?", whereArgs: [studentModel.uid]);
    }
  }

  Future<List<StudentModel>> getAllUsers(
      String name, String rollNo, String course, String section) async {
    List<Map<String, dynamic>>? a = await _database?.query("students",
        where:
            "fName LIKE ? AND rollNO LIKE ? AND course LIKE ? AND section LIKE ?",
        whereArgs: ['%$name%', '%$rollNo%', '%$course', '%$section%']);
    List<StudentModel> result = [];
    a?.forEach((element) {
      result.add(StudentModel.fromJson(element));
    });
    return result;
  }

  Future<void> updateStudentFeesPaid(StudentModel studentModel) async {
    await _database?.update("students", studentModel.toJson(),
        where: "uid = ?", whereArgs: [studentModel.uid]);
    try {
      var url = Uri.parse(constants.updateStudentFeesPaid);
      await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {"uid": studentModel.uid, "feesPaid": studentModel.feesPaid}));
    } catch (err) {
      print(err);
    }
  }
}
