import 'package:erp_management/pages/home/ui/home.dart';
import 'package:erp_management/pages/new user creation/functions/new_user_creation_functions.dart';
import 'package:flutter/material.dart';
import '../../model/student_model.dart';

final _formKey = GlobalKey<FormState>();

final _studentUidController = TextEditingController();
final _studentEmailController = TextEditingController();
final _studentFNameController = TextEditingController();
final _studentLNameController = TextEditingController();
final _studentRollNoController = TextEditingController();
final _studentDateOfBirthController = TextEditingController();
final _studentGenderController = TextEditingController();
final _studentAnnualFees = TextEditingController();
final _studentBusAllocatedController = TextEditingController();
final _studentContactController = TextEditingController();
final _parentContactController = TextEditingController();
final _studentAddressController = TextEditingController();
final _studentCourseController = TextEditingController();
final _studentSectionController = TextEditingController();
late String? _feesPaid;

class StudentDetails extends StatefulWidget {
  const StudentDetails(
      {required this.uid, required this.email, super.key, this.studentModel});

  final StudentModel? studentModel;
  final String uid;
  final String email;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _studentUidController.text = widget.studentModel?.uid ?? widget.uid;
      _studentEmailController.text = widget.studentModel?.email ?? widget.email;
      _studentFNameController.text = widget.studentModel?.fName ?? "";
      _studentLNameController.text = widget.studentModel?.lName ?? "";
      _studentRollNoController.text = widget.studentModel?.rollNo ?? "";
      _studentDateOfBirthController.text =
          widget.studentModel?.dateOfBirth ?? "";
      _studentGenderController.text = widget.studentModel?.gender ?? "";
      _studentAnnualFees.text = widget.studentModel?.annualFees ?? "";
      _studentBusAllocatedController.text =
          widget.studentModel?.busAllocated ?? "";
      _studentContactController.text =
          widget.studentModel?.studentContact ?? "";
      _parentContactController.text = widget.studentModel?.parentContact ?? "";
      _studentAddressController.text = widget.studentModel?.address ?? "";
      _studentCourseController.text = widget.studentModel?.course ?? "";
      _studentSectionController.text = widget.studentModel?.section ?? "";
      _feesPaid = widget.studentModel?.feesPaid;
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
          // First Name
          TextFormField(
            controller: _studentFNameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              return value == "" ? "Please enter the first name" : null;
            },
            decoration: const InputDecoration(
                label: Text("*Student's First Name"),
                border: OutlineInputBorder()),
          ),
          //Last Name
          TextFormField(
            controller: _studentLNameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
                label: Text("Student's Last Name"),
                border: OutlineInputBorder()),
          ),
          //Gender
          TextFormField(
            controller: _studentGenderController,
            validator: (value) {
              return value == "" ? "Field can't be remained empty" : null;
            },
            autofillHints: const ["Male", "Female", "Other"],
            decoration: const InputDecoration(
                label: Text("*Student's Gender"), border: OutlineInputBorder()),
          ),
          //AnnualFees
          TextFormField(
            controller: _studentAnnualFees,
            validator: (value) {
              return RegExp(r'^[0-9]').hasMatch(value ?? "")
                  ? null
                  : "Invalid input";
            },
            decoration: const InputDecoration(
                label: Text("*Student's Annual Fees"),
                border: OutlineInputBorder()),
          ),
          //DOB
          TextFormField(
            controller: _studentDateOfBirthController,
            validator: (value) {
              return value == "" ? "Field can't be remained empty" : null;
            },
            decoration: const InputDecoration(
                label: Text("*Student's D.O.B"), border: OutlineInputBorder()),
          ),
          //Roll no.
          TextFormField(
            controller: _studentRollNoController,
            validator: (value) {
              return value == "" ? "Field can't be remained empty" : null;
            },
            decoration: const InputDecoration(
                label: Text("*Student's Roll no."),
                border: OutlineInputBorder()),
          ),
          //Course
          TextFormField(
            controller: _studentCourseController,
            validator: (value) {
              return value == "" ? "field can't be remained empty" : null;
            },
            decoration: const InputDecoration(
                label: Text("*Student Course"), border: OutlineInputBorder()),
          ),
          //Section
          TextFormField(
            controller: _studentSectionController,
            validator: (value) {
              return value == "" ? "field can't be remained empty" : null;
            },
            decoration: const InputDecoration(
                label: Text("*Student Section"), border: OutlineInputBorder()),
          ),
          //Bus Allocated
          TextFormField(
            controller: _studentBusAllocatedController,
            decoration: const InputDecoration(
                label: Text("Allocated Bus Number"),
                border: OutlineInputBorder()),
          ),

          //Student Contact Detail
          TextFormField(
            controller: _studentContactController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              return value?.length != 10
                  ? "Please enter the proper phone number"
                  : null;
            },
            decoration: const InputDecoration(
                label: Text("*Student Contact"), border: OutlineInputBorder()),
          ),
          //Parent Contact Number
          TextFormField(
            controller: _parentContactController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              return value?.length != 10
                  ? "Please enter the proper phone number"
                  : null;
            },
            decoration: const InputDecoration(
                label: Text("*Parent Contact"), border: OutlineInputBorder()),
          ),

          TextFormField(
            controller: _studentAddressController,
            keyboardType: TextInputType.streetAddress,
            validator: (value) {
              if (value == "") {
                return "Please enter the address with pin code";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                label: Text("*Student Address"), border: OutlineInputBorder()),
          ),
          TextFormField(
            enabled: false,
            controller: _studentUidController,
            decoration: const InputDecoration(
                label: Text("Student UID"), border: OutlineInputBorder()),
          ),
          TextFormField(
            enabled: false,
            controller: _studentEmailController,
            decoration: const InputDecoration(
                label: Text("Student Email"), border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}

Future<void> sendStudentDetailsToServer() async {
  var valid = _formKey.currentState?.validate();
  if (valid!) {
    var isAdded = await NewUserCreationFunction().addStudentDetail(StudentModel(
        uid: _studentUidController.text,
        fName: _studentFNameController.text,
        lName: _studentLNameController.text,
        busAllocated: _studentBusAllocatedController.text,
        address: _studentAddressController.text,
        email: _studentEmailController.text,
        rollNo: _studentRollNoController.text,
        dateOfBirth: _studentDateOfBirthController.text,
        gender: _studentGenderController.text,
        studentContact: _studentContactController.text,
        parentContact: _parentContactController.text,
        course: _studentCourseController.text,
        section: _studentSectionController.text,
        annualFees: _studentAnnualFees.text,
        feesPaid: _feesPaid ?? "0"));
    if (isAdded) {
      Home().addDoneEvent();
    }
  }
}
