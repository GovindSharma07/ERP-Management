import 'package:erp_management/widgets/user_details/driver_detail_screen.dart';
import 'package:erp_management/widgets/user_details/student_detail_screen.dart';
import 'package:erp_management/widgets/user_details/teacher_detail_screen.dart';
import 'package:flutter/material.dart';

import '../extra/user_type.dart';

class UserTypeSelection extends StatefulWidget {
   UserTypeSelection({super.key});

  UserType? userType = UserType.teacher;

   Widget getDetailUi(String email,String uid) {
     if(userType == UserType.driver){
       return DriverDetails(email: email,uid: uid);
     }else if(userType == UserType.student){
       return StudentDetails(uid: uid, email: email);
     }
     else{
       return TeacherDetails(uid: uid, email: email);
     }
   }
  
  @override
  State<UserTypeSelection> createState() => _UserTypeSelectionState();
}

class _UserTypeSelectionState extends State<UserTypeSelection> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text("Teacher"),
          leading: Radio(
              value: UserType.teacher,
              groupValue: widget.userType,
              onChanged: (value) {
                setState(() {
                  widget.userType = value;
                });
              }),
        ),
        ListTile(
          title: const Text("Student"),
          leading: Radio(
              value: UserType.student,
              groupValue: widget.userType,
              onChanged: (value) {
                setState(() {
                  widget.userType = value;
                });
              }),
        ),
        ListTile(
          title: const Text("Driver"),
          leading: Radio(
              value: UserType.driver,
              groupValue: widget.userType,
              onChanged: (value) {
                setState(() {
                  widget.userType = value;
                });
              }),
        )
      ],
    );
  }
}
