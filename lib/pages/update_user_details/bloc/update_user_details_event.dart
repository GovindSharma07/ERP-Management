part of 'update_user_details_bloc.dart';

@immutable
sealed class UpdateUserDetailsEvent {}

final class UsersListEvent extends UpdateUserDetailsEvent{
  final UserType userType;
  final String name;
  final String email;
  final String uid;



  UsersListEvent({required this.userType, this.name = "", this.email = "", this.uid = ""}){
   print("$name");
  }
}
