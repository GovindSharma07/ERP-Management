import 'dart:convert';
import 'package:erp_management/database/users_database.dart';
import "package:erp_management/extra/constants.dart" as constants;
import 'package:erp_management/extra/user_type.dart';
import 'package:erp_management/model/student_model.dart';
import "package:http/http.dart" as http;

class NewUserCreationFunction {
  UserType userType = UserType.teacher;

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

  Future<bool> addDriverDetail(Map<String, String> detail) async {
    var url = Uri.parse(constants.addDriverDetailUrl);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(detail));
    return jsonDecode(response.body);
  }

  Future<bool> addTeacherDetail(Map<String, String> details) async {
    var url = Uri.parse(constants.addTeacherDetailUrl);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(details));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  Future<bool> addStudentDetail(StudentModel studentModel) async {
    var url = Uri.parse(constants.addStudentDetailUrl);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(studentModel.toJson()));
    print(jsonDecode(response.body));
    await UsersDatabaseHelper().addStudentDetails(studentModel);
    return jsonDecode(response.body);
  }
}
