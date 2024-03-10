import 'package:erp_management/pages/fees/ui/fees.dart';
import 'package:erp_management/pages/home/bloc/home_bloc.dart';
import 'package:erp_management/pages/new%20user%20creation/ui/new_user_creation.dart';
import 'package:erp_management/pages/update_user_details/ui/update_user_details.dart';
import 'package:erp_management/size/size.dart';
import 'package:erp_management/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

HomeBloc _homeBloc = HomeBloc();


class Home extends StatelessWidget {
   Home({super.key});

  void addDoneEvent() {
    _homeBloc.add(DoneEvent());
  }

  String title = "Home";

  @override
  Widget build(BuildContext context) {
    SizeType sizeType = Size().getSizeType(context);
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          switch (state) {
            case NewUserState():
              title = "Create New User";
              break;
            case FeesState():
              title = "Fees";
              break;
            case UpdateUserState():
                title = "Update User Details";
                break;
            case DoneState():
              title = "Done";
            default:
              title = "Home";
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              centerTitle: true,
            ),
            body: Row(
              children: [
                (sizeType == SizeType.fullWindow)
                    ? SizedBox(
                        width: 300,
                        child: CustomDrawer(_homeBloc),
                      )
                    : const SizedBox(),
                Expanded(child: _getHomeScreen(state))
              ],
            ),
            drawer: (sizeType == SizeType.halfWindow)
                ? Drawer(child: CustomDrawer(_homeBloc))
                : null,
          );
        });
  }

  Widget _getHomeScreen(HomeState state) {
    switch (state) {
      case NewUserState():
        return const NewUserCreation();
      case FeesState():
        return Fees();
      case UpdateUserState():
        return const UpdateUserDetails();
      case DoneState():
        return Image.asset(
          "assets/bg/done.png",
          fit: BoxFit.scaleDown,
        );
      default:
        return Center(
            child: Image.asset(
          "assets/bg/college.png",
          fit: BoxFit.fill,
        ));
    }
  }
}
