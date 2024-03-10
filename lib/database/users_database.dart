import 'dart:convert';

import 'package:erp_management/model/student_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:erp_management/extra/constants.dart' as constants;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../model/driver_model.dart';
import '../model/teacher_model.dart';

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
      await _database?.execute("CREATE TABLE IF NOT EXISTS teacher ("
          "uid TEXT NOT NULL PRIMARY KEY,"
          "email TEXT NOT NULL,"
          "fName TEXT NOT NULL,"
          "lName TEXT NOT NULL,"
          "department TEXT NOT NULL,"
          "busAllocated TEXT NOT NULL,"
          "contact TEXT NOT NULL,"
          "address TEXT NOT NULL)");
      await _database?.execute("CREATE TABLE IF NOT EXISTS driver ("
          "uid TEXT NOT NULL PRIMARY KEY,"
          "email TEXT NOT NULL,"
          "fName TEXT NOT NULL,"
          "lName TEXT NOT NULL,"
          "busNumber TEXT NOT NULL,"
          "contact TEXT NOT NULL,"
          "address TEXT NOT NULL");
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

  Future<List<StudentModel>> getAllStudents(
      String name, String rollNo, String course, String section) async {
    List<Map<String, dynamic>>? a = await _database?.query("students",
        where:
            "fName LIKE ? AND rollNO LIKE ? AND course LIKE ? AND section LIKE ?",
        whereArgs: ['%$name%', '%$rollNo%', '%$course%', '%$section%']);
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

  Future<void> addTeacherDetails(TeacherModel teacherModel) async {
    if ((await _database?.rawQuery(
            "SELECT uid FROM students WHERE uid = ?", [teacherModel.uid]))!
        .isEmpty) {
      await _database?.insert("teacher", teacherModel.toJson());
    } else {
      await _database?.update("students", teacherModel.toJson(),
          where: "uid = ?", whereArgs: [teacherModel.uid]);
    }
  }

  Future<List<TeacherModel>> getAllDriver(
      String name, String department) async {
    List<Map<String, dynamic>>? a = await _database?.query("teacher",
        where: "fName LIKE ? AND department LIKE ?",
        whereArgs: ['%$name%', '%$department%']);
    List<TeacherModel> result = [];
    a?.forEach((element) {
      result.add(TeacherModel.fromJson(element));
    });
    return result;
  }

  Future<void> addDriverDetails(DriverModel driverModel) async {
    if ((await _database?.rawQuery(
            "SELECT uid FROM students WHERE uid = ?", [driverModel.uid]))!
        .isEmpty) {
      await _database?.insert("driver", driverModel.toJson());
    } else {
      await _database?.update("driver", driverModel.toJson(),
          where: "uid = ?", whereArgs: [driverModel.uid]);
    }
  }

  Future<List<DriverModel>> getAllTeachers(String name) async {
    List<Map<String, dynamic>>? a = await _database?.query("teacher",
        where: "fName LIKE ?",
        whereArgs: ['%$name%']);
    List<DriverModel> result = [];
    a?.forEach((element) {
      result.add(DriverModel.fromJson(element));
    });
    return result;
  }
}
