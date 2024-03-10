part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class NewUserState extends HomeState{}

final class FeesState extends HomeState{}

final class UpdateUserState extends HomeState{}

final class DoneState extends HomeState{}