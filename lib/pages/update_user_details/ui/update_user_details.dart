import 'package:erp_management/extra/user_type.dart';
import 'package:erp_management/pages/new%20user%20creation/functions/new_user_creation_functions.dart';
import 'package:erp_management/widgets/user_details/driver_detail_screen.dart';
import 'package:erp_management/widgets/user_details/student_detail_screen.dart';
import 'package:erp_management/widgets/user_details/teacher_detail_screen.dart';
import 'package:erp_management/widgets/user_type_selection.dart';
import 'package:flutter/material.dart';

UserType? _userType = UserType.teacher;


class UpdateUserDetails extends StatefulWidget {
  const UpdateUserDetails({super.key});

  @override
  State<UpdateUserDetails> createState() => _UpdateUserDetailsState();
}

class _UpdateUserDetailsState extends State<UpdateUserDetails> {
  bool _processing = false;
  final UserTypeSelection _userTypeSelection = UserTypeSelection();


  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        controlsBuilder: (context, controlDetails) {
          return Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: _processing
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                children: [
                  ElevatedButton(
                    onPressed: controlDetails.onStepContinue,
                    child: const Text('Next'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: controlDetails.onStepCancel,
                    child: const Text('Back'),
                  ),
                ],
              ));
        },
        onStepContinue: () async {
          setState(() {
            _processing = true;
          });
          if (_currentStep == 0) {
            _userType = _userTypeSelection.userType;
            setState(() {
              _currentStep = 1;
            });
          }
          else if (_currentStep == 2) {
            if (_userType == UserType.driver) {
              await sendDriverDetailsToServer();
            } else if (_userType == UserType.teacher) {
              await sendTeacherDetailsToServer();
            } else if (_userType == UserType.student) {
              await sendStudentDetailsToServer();
            }
          }
          setState(() {
            _processing = false;
          });
        },
        onStepCancel: () {
          if (_currentStep != 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
        steps: [
          Step(title: const Text("Select Type"), content: _userTypeSelection),
          Step(title: const Text("Select User"), content: Placeholder()),
          Step(
              title: const Text("Details"),
              content: _userTypeSelection.getDetailUi("", ""))
        ]);
  }
}
