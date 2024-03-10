part of 'fees_bloc.dart';

@immutable
sealed class FeesState {}

final class FeesInitial extends FeesState {
  final String name,rollNo,course,section;
  FeesInitial({this.name = "",this.rollNo = "",this.course = "",this.section = ""});
}

final class FeesStudentSelectedState extends FeesState{
  final StudentModel studentModel;

  FeesStudentSelectedState(this.studentModel);
}
