import 'dart:convert';
import 'package:erp_management/database/users_database.dart';
import "package:erp_management/extra/constants.dart" as constants;
import 'package:erp_management/model/driver_model.dart';
import 'package:erp_management/model/student_model.dart';
import 'package:erp_management/model/teacher_model.dart';
import "package:http/http.dart" as http;

class NewUserCreationFunction {


  Future<List<dynamic>> createUserUsingEmailAndPassword(
      String email, String password) async {
    var url = Uri.parse(constants.createUserUrl);
    var body = {
      "email": email,
      "password": password,
    };
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    return jsonDecode(response.body);
  }

  Future<bool> addDriverDetail(DriverModel driverModel) async {
    var url = Uri.parse(constants.addDriverDetailUrl);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(driverModel.toJson()));
    await UsersDatabaseHelper().addDriverDetails(driverModel);
    return jsonDecode(response.body);
  }

  Future<bool> addTeacherDetail(TeacherModel teacherModel) async {
    var url = Uri.parse(constants.addTeacherDetailUrl);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(teacherModel.toJson()));
    await UsersDatabaseHelper().addTeacherDetails(teacherModel);
    return jsonDecode(response.body);
  }

  Future<bool> addStudentDetail(StudentModel studentModel) async {
    var url = Uri.parse(constants.addStudentDetailUrl);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(studentModel.toJson()));
    await UsersDatabaseHelper().addStudentDetails(studentModel);
    return jsonDecode(response.body);
  }
}
