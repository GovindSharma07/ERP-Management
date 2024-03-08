part of 'fees_bloc.dart';

@immutable
sealed class FeesState {}

final class FeesInitial extends FeesState {}

final class FeesStudentSelectedState extends FeesState{
  final StudentModel studentModel;

  FeesStudentSelectedState(this.studentModel);
}
