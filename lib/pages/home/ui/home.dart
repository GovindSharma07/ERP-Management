import 'package:erp_management/pages/home/bloc/home_bloc.dart';
import 'package:erp_management/pages/new%20user%20creation/ui/new_user_creation.dart';
import 'package:erp_management/size/size.dart';
import 'package:erp_management/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

HomeBloc _homeBloc = HomeBloc();


class Home extends StatefulWidget {
  const Home({super.key});

  void addDoneEvent() {
    _homeBloc.add(DoneEvent());
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String title = "Home";

  @override
  Widget build(BuildContext context) {
    SizeType sizeType = Size().getSizeType(context);
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          if (state is NewUserState) {
            title = "Create New User";
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
    if (state is NewUserState) {
      return const NewUserCreation();
    } else if (state is DoneState) {
      return Image.asset(
        "assets/bg/done.png",
        fit: BoxFit.fill,
      );
    } else {
      return Center(
          child: Image.asset(
        "assets/bg/college.png",
        fit: BoxFit.fill,
      ));
    }
  }
}
