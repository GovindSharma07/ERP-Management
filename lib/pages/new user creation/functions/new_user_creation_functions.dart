import 'dart:convert';

import 'package:erp_management/extra/user_type.dart';
import "package:http/http.dart" as http;

class NewUserCreationFunction {
  UserType userType = UserType.teacher;

  Future<List<dynamic>> createUserUsingEmailAndPassword(
      String email, String password) async {
    var url = Uri.parse(
        "https://fcm-notification-server.onrender.com/api/user/createUser");
    var body = {
      "email": email,
      "password": password,
    };
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));
    return jsonDecode(response.body);
  }

  Future<dynamic> addDriverDetail(Map<String, String> detail) async {
    var url = Uri.parse(
        "https://fcm-notification-server.onrender.com/api/user/addDriverDetails");

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(detail));
    return jsonDecode(response.body);
  }
}
