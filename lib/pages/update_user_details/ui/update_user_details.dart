import 'package:erp_management/extra/user_type.dart';
import 'package:erp_management/model/driver_model.dart';
import 'package:erp_management/model/student_model.dart';
import 'package:erp_management/model/teacher_model.dart';
import 'package:erp_management/pages/update_user_details/bloc/update_user_details_bloc.dart';
import 'package:erp_management/widgets/user_details/user_bubble.dart';
import 'package:erp_management/widgets/user_type_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/users_database.dart';
import '../../../widgets/user_details/driver_detail_screen.dart';
import '../../../widgets/user_details/student_detail_screen.dart';
import '../../../widgets/user_details/teacher_detail_screen.dart';

UserType? _userType = UserType.teacher;

class UpdateUserDetails extends StatefulWidget {
  const UpdateUserDetails({super.key});

  @override
  State<UpdateUserDetails> createState() => _UpdateUserDetailsState();
}

class _UpdateUserDetailsState extends State<UpdateUserDetails> {
  bool _processing = false;
  final UserTypeSelection _userTypeSelection = UserTypeSelection();

  static int _currentStep = 0;
  final userDb = UsersDatabaseHelper();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final uidController = TextEditingController();

  StudentModel _studentModel = StudentModel(
      uid: "uid",
      email: "email",
      fName: "fName",
      lName: "lName",
      rollNo: "rollNo",
      dateOfBirth: "dateOfBirth",
      gender: "gender",
      annualFees: "annualFees",
      busAllocated: "busAllocated",
      studentContact: "studentContact",
      parentContact: "parentContact",
      address: "address",
      course: "course",
      section: "section");
  TeacherModel _teacherModel = TeacherModel(
      uid: "uid",
      email: "email",
      address: "address",
      lName: "lName",
      fName: "fName",
      contact: "contact",
      department: "department",
      busAllocated: "busAllocated");
  DriverModel _driverModel = DriverModel(
      uid: "uid",
      fName: "fName",
      lName: "lName",
      busNumber: "busNumber",
      contact: "contact",
      address: "address",
      email: "email");

  final UpdateUserDetailsBloc _bloc = UpdateUserDetailsBloc();

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
                        (_currentStep == 1)
                            ? const SizedBox()
                            : ElevatedButton(
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
            _bloc.add(UsersListEvent(userType: _userType!));
            setState(() {
              _currentStep = 1;
            });
          } else if (_currentStep == 2) {
            if (_userType == UserType.driver) {
              await sendDriverDetailsToServer();
              _currentStep = 0;
            } else if (_userType == UserType.teacher) {
              await sendTeacherDetailsToServer();
              _currentStep = 0;
            } else if (_userType == UserType.student) {
              await sendStudentDetailsToServer();
              _currentStep = 0;
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
          Step(
              title: const Text("Select User"),
              content: BlocBuilder<UpdateUserDetailsBloc,
                      UpdateUserDetailsState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is UserListState) {
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: nameController,
                                  onChanged: (val) {
                                    _bloc.add(UsersListEvent(
                                        userType: _userType!,
                                        name: nameController.text,
                                        email: emailController.text,
                                        uid: uidController.text));
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Name"),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: emailController,
                                  onChanged: (val) {
                                    _bloc.add(UsersListEvent(
                                        userType: _userType!,
                                        name: nameController.text,
                                        email: emailController.text,
                                        uid: uidController.text));
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Email"),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: uidController,
                                  onChanged: (val) {
                                    _bloc.add(UsersListEvent(
                                        userType: _userType!,
                                        name: nameController.text,
                                        email: emailController.text,
                                        uid: uidController.text));
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "uid"),
                                ),
                              )
                            ],
                          ),
                        ),
                        FutureBuilder(
                            future: (state.userType == UserType.teacher)
                                ? userDb.getAllTeachers(
                                    state.name, "", state.email, state.uid)
                                : (state.userType == UserType.student)
                                    ? userDb.getAllStudents(state.name, "", "",
                                        "", state.email, state.uid)
                                    : userDb.getAllDriver(
                                        state.name, state.email, state.uid),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SizedBox(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        if (state.userType ==
                                            UserType.teacher) {
                                          return InkWell(
                                            onTap: () {
                                              _teacherModel = snapshot
                                                  .data![index] as TeacherModel;
                                              setState(() {
                                                _currentStep = 2;
                                              });
                                            },
                                            child: UserBubble(
                                              teacherModel: snapshot
                                                  .data![index] as TeacherModel,
                                            ),
                                          );
                                        } else if (state.userType ==
                                            UserType.student) {
                                          return InkWell(
                                            onTap: () {
                                              _studentModel = snapshot
                                                  .data![index] as StudentModel;
                                              setState(() {
                                                _currentStep = 2;
                                              });
                                            },
                                            child: UserBubble(
                                              studentModel: snapshot
                                                  .data![index] as StudentModel,
                                            ),
                                          );
                                        } else {
                                          return InkWell(
                                            onTap: () {
                                              _driverModel = snapshot
                                                  .data![index] as DriverModel;
                                              setState(() {
                                                _currentStep = 2;
                                              });
                                            },
                                            child: UserBubble(
                                              driverModel: snapshot.data![index]
                                                  as DriverModel,
                                            ),
                                          );
                                        }
                                      }),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text("Error : ${snapshot.error}"));
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            })
                      ]);
                    } else {
                      return Container(
                        color: Colors.red,
                        width: 500,
                        height: 600,
                      );
                    }
                  })),
          Step(
              title: const Text("Details"),
              content: (_userType == UserType.student)
                  ? _userTypeSelection.getDetailUi(
                      _studentModel.email, _studentModel.uid,
                      studentModel: _studentModel)
                  : (_userType == UserType.teacher)
                      ? _userTypeSelection.getDetailUi(
                          _teacherModel.email, _teacherModel.uid,
                          teacherModel: _teacherModel)
                      : _userTypeSelection.getDetailUi(
                          _driverModel.email, _driverModel.uid,
                          driverModel: _driverModel))
        ]);
  }
}
