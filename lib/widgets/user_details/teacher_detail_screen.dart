import 'package:erp_management/pages/home/ui/home.dart';
import 'package:erp_management/pages/new user creation/functions/new_user_creation_functions.dart';
import 'package:flutter/material.dart';
import '../../model/teacher_model.dart';

final _formKey = GlobalKey<FormState>();

final _teacherFNameController = TextEditingController();
final _teacherLNameController = TextEditingController();
final _teacherBusAllocatedController = TextEditingController();
final _teacherContactController = TextEditingController();
final _teacherAddressController = TextEditingController();
final _teacherUidController = TextEditingController();
final _teacherEmailController = TextEditingController();
final _teacherDepartmentController = TextEditingController();

class TeacherDetails extends StatefulWidget {
  const TeacherDetails({required this.uid, required this.email,this.teacherModel, super.key});
  final TeacherModel? teacherModel;
  final String uid;
  final String email;

  @override
  State<TeacherDetails> createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetails> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _teacherUidController.text =widget.teacherModel?.uid ?? widget.uid;
      _teacherEmailController.text = widget.teacherModel?.email ?? widget.email;
      _teacherFNameController.text = widget.teacherModel?.fName ?? "";
      _teacherLNameController.text = widget.teacherModel?.lName ?? "";
      _teacherDepartmentController.text = widget.teacherModel?.department ?? "";
      _teacherBusAllocatedController.text = widget.teacherModel?.busAllocated?? "";
      _teacherContactController.text = widget.teacherModel?.contact?? "";
      _teacherAddressController.text = widget.teacherModel?.fName ?? "";
    });
    return Form(
      key: _formKey,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
            childAspectRatio: 6),
        shrinkWrap: true,
        children: [
          TextFormField(
            controller: _teacherFNameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == "") {
                return "Please enter the first name";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                label: Text("*Teacher's First Name"),
                border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: _teacherLNameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
                label: Text("Teacher's Last Name"),
                border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: _teacherDepartmentController,
            validator: (value) {
              if (value == "") {
                return "field can't be remained empty";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                label: Text("*Teacher Department"),
                border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: _teacherBusAllocatedController,
            decoration: const InputDecoration(
                label: Text("Allocated Bus Number"),
                border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: _teacherContactController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value?.length != 10) {
                return "Please enter the proper phone number";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                label: Text("*Teacher Contact"), border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: _teacherAddressController,
            keyboardType: TextInputType.streetAddress,
            validator: (value) {
              if (value == "") {
                return "Please enter the address with pin code";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                label: Text("*Teacher Address"), border: OutlineInputBorder()),
          ),
          TextFormField(
            enabled: false,
            controller: _teacherUidController,
            decoration: const InputDecoration(
                label: Text("Teacher UID"), border: OutlineInputBorder()),
          ),
          TextFormField(
            enabled: false,
            controller: _teacherEmailController,
            decoration: const InputDecoration(
                label: Text("Teacher Email"), border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}

Future<void> sendTeacherDetailsToServer() async {
  var valid = _formKey.currentState?.validate();
  if (valid!) {
    var isAdded = await NewUserCreationFunction().addTeacherDetail(TeacherModel(
        uid: _teacherUidController.text,
        fName: _teacherFNameController.text,
        lName: _teacherLNameController.text,
        busAllocated: _teacherBusAllocatedController.text,
        contact: _teacherContactController.text,
        address: _teacherAddressController.text,
        email: _teacherEmailController.text,
        department: _teacherDepartmentController.text));
    if (isAdded) {
      Home().addDoneEvent();
    }
  }
}
