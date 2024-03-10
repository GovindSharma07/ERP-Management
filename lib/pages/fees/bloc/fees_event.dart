part of 'fees_bloc.dart';

@immutable
sealed class FeesEvent {}

final class FeesStudentSelectedEvent extends FeesEvent{
  final StudentModel studentModel;

  FeesStudentSelectedEvent(this.studentModel);
}

final class FeesInitialEvent extends FeesEvent{
  final String name,rollNo,course,section;
  FeesInitialEvent({this.name = "",this.rollNo = "",this.course = "",this.section = ""});
}