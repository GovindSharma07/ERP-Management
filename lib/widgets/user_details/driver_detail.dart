import 'package:erp_management/model/driver.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

final _driverFNameController = TextEditingController();
final _driverLNameController = TextEditingController();
final _driverBusNumberController = TextEditingController();
final _driverContactController = TextEditingController();
final _driverAddressController = TextEditingController();
final _driverUidController = TextEditingController();
final _driverEmailController = TextEditingController();

class DriverDetails extends StatefulWidget {
  const DriverDetails({required this.uid, required this.email, super.key});

  final String uid;
  final String email;

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  @override
  void dispose() {
    _driverAddressController.dispose();
    _driverContactController.dispose();
    _driverBusNumberController.dispose();
    _driverLNameController.dispose();
    _driverFNameController.dispose();
    _driverEmailController.dispose();
    _driverUidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _driverUidController.text = widget.uid;
      _driverEmailController.text = widget.email;
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
            controller: _driverFNameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == "") {
                return "Please enter the first name";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                label: Text("*Driver's First Name"),
                border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: _driverLNameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
                label: Text("Driver's Last Name"),
                border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: _driverBusNumberController,
            validator: (value) {
              if (value == "") {
                return "Please enter the bus number";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                label: Text("*Bus Number"), border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: _driverContactController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value?.length != 10) {
                return "Please enter the proper phone number";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                label: Text("*Driver Contact"), border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: _driverAddressController,
            keyboardType: TextInputType.streetAddress,
            validator: (value) {
              if (value == "") {
                return "Please enter the address with pin code";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                label: Text("*Driver Address"), border: OutlineInputBorder()),
          ),
          TextFormField(
            enabled: false,
            controller: _driverUidController,
            decoration: const InputDecoration(
                label: Text("Driver UID"), border: OutlineInputBorder()),
          ),
          TextFormField(
            enabled: false,
            controller: _driverEmailController,
            decoration: const InputDecoration(
                label: Text("Driver Email"), border: OutlineInputBorder()),
          ),
        ],

      ),
    );
  }
}

Future<void> sendDriverDetailsToServer() async {
  var valid = _formKey.currentState?.validate();
  if(valid!){
    print(DriverModel(uid: _driverUidController.text, fName: _driverFNameController.text, lName:( _driverLNameController.text == "") ? " ": _driverLNameController.text, busNumber: _driverBusNumberController.text, contactNumber: _driverContactController.text, address: _driverAddressController.text, email: _driverEmailController.text).toJson());
  }
}
