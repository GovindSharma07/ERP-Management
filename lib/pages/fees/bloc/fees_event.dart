part of 'fees_bloc.dart';

@immutable
sealed class FeesEvent {}

final class FeesStudentSelectedEvent extends FeesEvent{
  final StudentModel studentModel;

  FeesStudentSelectedEvent(this.studentModel);
}

final class FeesInitialEvent extends FeesEvent{}