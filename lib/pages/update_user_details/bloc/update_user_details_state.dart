part of 'update_user_details_bloc.dart';

@immutable
sealed class UpdateUserDetailsState {}

final class UpdateUserDetailsInitial extends UpdateUserDetailsState {}

final class UserListState extends UpdateUserDetailsState{
  final UserType userType;
  final String name;
  final String email;
  final String uid;
  UserListState(this.userType, this.name, this.email, this.uid){
    print("$name");
  }
}