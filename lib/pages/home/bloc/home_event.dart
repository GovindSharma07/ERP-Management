part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class NewUserEvent extends HomeEvent{}
class FeesEvent extends HomeEvent{}
class UpdateUserEvent extends HomeEvent{}

class DoneEvent extends HomeEvent{}