import "package:erp_management/database/users_database.dart";
import "package:erp_management/model/student_model.dart";
import "package:erp_management/pages/fees/bloc/fees_bloc.dart";
import "package:erp_management/pages/fees/ui/fees_submit_screen.dart";
import "package:erp_management/widgets/student_detail_bubble.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class Fees extends StatelessWidget {
  Fees({super.key});

  final userDb = UsersDatabaseHelper();

  final FeesBloc _feesBloc = FeesBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeesBloc, FeesState>(
        bloc: _feesBloc,
        builder: (context, state) {
          if (state is FeesStudentSelectedState) {
            return FeesSubmitScreen(
              studentModel: state.studentModel,
              feesBloc: _feesBloc,
            );
          } else {
            return Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Placeholder(
                      child: Text("Student name"),
                    ),
                    Placeholder(
                      child: Text("student roll no "),
                    ),
                    Placeholder(
                      child: Text('course'),
                    ),
                    Placeholder(
                      child: Text("section"),
                    )
                  ],
                ),
                Expanded(
                  child: FutureBuilder<List<StudentModel>>(
                      future: userDb.getAllUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return UserDetailBubble(
                                  studentModel: snapshot.data![index],
                                  feesBloc: _feesBloc,
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text("Error : ${snapshot.error}"));
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                )
              ],
            );
          }
        });
  }
}
