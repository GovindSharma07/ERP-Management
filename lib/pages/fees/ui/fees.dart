import "package:erp_management/database/users_database.dart";
import "package:erp_management/model/student_model.dart";
import "package:erp_management/pages/fees/bloc/fees_bloc.dart";
import "package:erp_management/pages/fees/ui/fees_submit_screen.dart";
import "package:erp_management/widgets/student_detail_bubble.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class Fees extends StatelessWidget {
  Fees({super.key});

  final userDb = UsersDatabaseHelper();

  final name = TextEditingController();
  final rollNo = TextEditingController();
  final course = TextEditingController();
  final section = TextEditingController();

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
          } else if(state is FeesInitial){
            return Column(
              children: [

                 Container(
                   margin: const EdgeInsets.all(20),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: name,
                          onChanged: (val){
                            _feesBloc.add(FeesInitialEvent(name: name.text,rollNo: rollNo.text,course: course.text,section: section.text));
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Name"
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: rollNo,
                          onChanged: (val){
                            _feesBloc.add(FeesInitialEvent(name: name.text,rollNo: rollNo.text,course: course.text,section: section.text));
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                              labelText: "Roll No"
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: course,
                          onChanged: (val){
                            _feesBloc.add(FeesInitialEvent(name: name.text,rollNo: rollNo.text,course: course.text,section: section.text));
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                              labelText: "Course"
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: name,
                          onChanged: (val){
                            _feesBloc.add(FeesInitialEvent(name: name.text,rollNo: rollNo.text,course: course.text,section: section.text));
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                              labelText: "Section"
                          ),
                        ),
                      )
                    ],
                                   ),
                 ),
                Expanded(
                  child: FutureBuilder<List<StudentModel>>(
                      future: userDb.getAllUsers(state.name,state.rollNo,state.course,state.section),
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
          }else{
            return const Expanded(child: SizedBox());
          }
        });
  }
}
