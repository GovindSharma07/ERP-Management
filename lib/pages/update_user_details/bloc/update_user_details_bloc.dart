import 'package:bloc/bloc.dart';
import 'package:erp_management/extra/user_type.dart';
import 'package:meta/meta.dart';

part 'update_user_details_event.dart';
part 'update_user_details_state.dart';

class UpdateUserDetailsBloc extends Bloc<UpdateUserDetailsEvent, UpdateUserDetailsState> {
  UpdateUserDetailsBloc() : super(UpdateUserDetailsInitial()) {
    on<UsersListEvent>((event, emit) {
      emit(UserListState(event.userType, event.name, event.email, event.uid));
    });
  }
}
