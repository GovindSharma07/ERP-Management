import 'package:erp_management/extra/user_type.dart';
import 'package:erp_management/pages/new%20user%20creation/functions/new_user_creation_functions.dart';
import 'package:erp_management/widgets/user_details/driver_detail.dart';
import 'package:flutter/material.dart';

UserType? _userType = UserType.teacher;
NewUserCreationFunction _function = NewUserCreationFunction();

class NewUserCreation extends StatefulWidget {
  const NewUserCreation({super.key});

  @override
  State<NewUserCreation> createState() => _NewUserCreationState();
}

class _NewUserCreationState extends State<NewUserCreation> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  String _errorMessage = "";
  String _email = "";
  String _password = "";
  String _uid = "";
  bool _processing = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
            _function.userType = _userType!;
            setState(() {
              _currentStep = 1;
            });
          } else if (_currentStep == 1) {
            if (_email.isEmpty || _password.isEmpty) {
              setState(() {
                _errorMessage = "Field can't be remained empty";
              });
            } else {
              print("Entered");
              var response = await _function.createUserUsingEmailAndPassword(
                  _email, _password);
              if (response[0]) {
                _uid = response[1]["uid"];
                _currentStep = 2;
                setState(() {});
              } else {
                _errorMessage = response[1]["message"];
              }
            }
          }else if(_currentStep == 2){
            if(_userType == UserType.driver){
              sendDriverDetailsToServer();
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
          const Step(title: Text("Select Type"), content: UserTypeSelection()),
          Step(
              title: const Text("Email and Password"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            _email = value;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Email")),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {
                            _password = value;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Password")),
                        ),
                      )
                    ],
                  ),
                ],
              )),
          Step(title: const Text("Details"), content: _getDetailUi())
        ]);
  }

  Widget _getDetailUi() {
    return DriverDetails(email: _email,uid: _uid);
  }
}

class UserTypeSelection extends StatefulWidget {
  const UserTypeSelection({super.key});

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
              groupValue: _userType,
              onChanged: (value) {
                setState(() {
                  _userType = value;
                });
              }),
        ),
        ListTile(
          title: const Text("Student"),
          leading: Radio(
              value: UserType.student,
              groupValue: _userType,
              onChanged: (value) {
                setState(() {
                  _userType = value;
                });
              }),
        ),
        ListTile(
          title: const Text("Driver"),
          leading: Radio(
              value: UserType.driver,
              groupValue: _userType,
              onChanged: (value) {
                setState(() {
                  _userType = value;
                });
              }),
        )
      ],
    );
  }
}
