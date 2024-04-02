import 'package:erp_management/model/driver_model.dart';
import 'package:erp_management/model/student_model.dart';
import 'package:erp_management/model/teacher_model.dart';
import 'package:erp_management/pages/update_user_details/bloc/update_user_details_bloc.dart';
import 'package:flutter/material.dart';

import '../../model/uneModel.dart';

class UserBubble extends StatelessWidget {
  UserBubble(
      {super.key, this.driverModel, this.teacherModel, this.studentModel});

  final StudentModel? studentModel;
  final TeacherModel? teacherModel;
  final DriverModel? driverModel;
  UNE? _une;

  @override
  Widget build(BuildContext context) {
    _une = _getUNE();
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        border:
            Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
        gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.deepPurple]),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              _une!.uid,
              style: const TextStyle(color: Colors.black),
            ),
            const VerticalDivider(
              thickness: 2,
              color: Colors.black,
            ),
            Text(_une!.name,
                style: const TextStyle(
                  color: Colors.black,
                )),
            const VerticalDivider(
              thickness: 2,
              color: Colors.black,
            ),
            Text(_une!.email, style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }

  UNE _getUNE() {
    if (studentModel != null) {
      return UNE(
          email: studentModel!.email,
          name: studentModel!.fName,
          uid: studentModel!.uid);
    }
    if (teacherModel != null) {
      return UNE(
          email: teacherModel!.email,
          name: teacherModel!.fName,
          uid: teacherModel!.uid);
    }
    if (driverModel != null) {
      return UNE(
          email: driverModel!.email,
          name: driverModel!.fName,
          uid: driverModel!.uid);
    }
    return UNE(email: "", name: "", uid: "");
  }
}
