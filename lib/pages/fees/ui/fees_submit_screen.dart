import 'package:erp_management/database/fees_database.dart';
import 'package:erp_management/model/fees_model.dart';
import 'package:erp_management/model/student_model.dart';
import 'package:erp_management/pages/fees/bloc/fees_bloc.dart';
import 'package:erp_management/pages/fees/ui/fees.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FeesSubmitScreen extends StatelessWidget {
  FeesSubmitScreen(
      {super.key, required this.studentModel, required this.feesBloc});

  final StudentModel studentModel;
  final FeesBloc feesBloc;
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _slipNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Table(
              border: TableBorder.all(width: 2),
              children: [
                TableRow(children: [
                  _tableText("Name"),
                  _tableText("${studentModel.fName} ${studentModel.lName}")
                ]),
                TableRow(children: [
                  _tableText("Roll No"),
                  _tableText(studentModel.rollNo)
                ]),
                TableRow(children: [
                  _tableText("Course"),
                  _tableText(studentModel.course)
                ]),
                TableRow(children: [
                  _tableText("Section"),
                  _tableText(studentModel.section)
                ]),
                TableRow(children: [
                  _tableText("Annual Fees"),
                  _tableText(studentModel.annualFees)
                ]),
                TableRow(children: [
                  _tableText("Fees Remaining"),
                  _tableText(
                      "${int.parse(studentModel.annualFees) -
                          int.parse(studentModel.feesPaid)}")
                ]),
                _inputDataTableRows()[1],
                _inputDataTableRows()[0]
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        _buttons(context)
      ],
    );
  }

  List<TableRow> _inputDataTableRows() {
    return [
      TableRow(children: [
        _tableText("Amount submitting"),
        TextFormField(
          controller: _amountController,
          validator: (value) {
            if (value == "") {
              return "Amount cant be Empty";
            } else if (RegExp(r'[^0-9]').hasMatch(value ?? "")) {
              return "Please Enter valid input";
            } else if (int.parse(value ?? "0") >
                (int.parse(studentModel.annualFees) -
                    int.parse(studentModel.feesPaid))) {
              return "Amount cant more than fees remaining";
            } else if (int.parse(value ?? "0") < 0) {
              return "Amount can't be negative";
            } else {
              return null;
            }
          },
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        )
      ]),
      TableRow(children: [
        _tableText("Slip Number"),
        TextFormField(
          controller: _slipNumberController,
          validator: (value) {
            if (value == "") {
              return "Slip Number Can't be null";
            } else {
              return null;
            }
          },
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        )
      ])
    ];
  }

  Row _buttons(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
            onPressed: () => feesBloc.add(FeesInitialEvent()),
            icon: const Icon(Icons.keyboard_backspace),
            label: const Text("Back")),
        ElevatedButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        AlertDialog(
                          title: Text(
                              "Payment of ${_amountController.text} received"),
                          actions: [
                            ElevatedButton.icon(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.close),
                                label: const Text("Close")),
                            ElevatedButton.icon(
                                onPressed: () async {
                                  await FeesDatabaseHelper().addFeesDetails(
                                      FeesModel(
                                          studentModel.uid,
                                          int.parse(_amountController.text),
                                          _slipNumberController.text,
                                          DateTime.now()));
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context)
                                     .showSnackBar(const SnackBar(content: Text("Done")));
                                  feesBloc.add(FeesInitialEvent());
                                },
                                icon: const Icon(Icons.done),
                                label: const Text("Submit"))
                          ],
                        ));
              }
            },
            icon: const Icon(Icons.add),
            label: const Text("Submit"))
      ],
    );
  }

  Text _tableText(String value) {
    return Text(
      value,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    );
  }
}
