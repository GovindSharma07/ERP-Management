import 'package:erp_management/model/student_model.dart';
import 'package:erp_management/pages/fees/bloc/fees_bloc.dart';
import 'package:flutter/material.dart';

class StudentFeesBubble extends StatefulWidget {
  const StudentFeesBubble({
    super.key,
    required this.studentModel,
    required this.feesBloc,
  });

  final FeesBloc feesBloc;
  final StudentModel studentModel;

  @override
  State<StudentFeesBubble> createState() => _StudentFeesBubbleState();
}

class _StudentFeesBubbleState extends State<StudentFeesBubble> {
  @override
  Widget build(BuildContext context) {
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
              widget.studentModel.fName,
              style: const TextStyle(color: Colors.white),
            ),
            const VerticalDivider(
              thickness: 2,
              color: Colors.black,
            ),
            Text(widget.studentModel.rollNo,
                style: const TextStyle(color: Colors.white)),
            const VerticalDivider(
              thickness: 2,
              color: Colors.black,
            ),
            Text(widget.studentModel.course,
                style: const TextStyle(color: Colors.white)),
            const VerticalDivider(
              thickness: 2,
              color: Colors.black,
            ),
            Text(widget.studentModel.section,
                style: const TextStyle(color: Colors.white)),
            const VerticalDivider(
              thickness: 2,
              color: Colors.black,
            ),
            Text(widget.studentModel.annualFees,
                style: const TextStyle(color: Colors.white)),
            const VerticalDivider(
              thickness: 2,
              color: Colors.black,
            ),
            ElevatedButton.icon(
                onPressed: () => widget.feesBloc
                    .add(FeesStudentSelectedEvent(widget.studentModel)),
                icon: const Icon(
                  Icons.payments_outlined,
                  color: Colors.white,
                ),
                label: const Text("Pay"))
          ],
        ),
      ),
    );
  }
}
