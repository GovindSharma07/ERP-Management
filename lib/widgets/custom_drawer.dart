import 'package:erp_management/pages/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(this._bloc, {super.key});

  final HomeBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                _bloc.add(NewUserEvent());
              },
              child: _getElevatedButton("Create New User",Icons.add_reaction_outlined)),
          _getElevatedButton("Update User Details",Icons.update_outlined),
          _getElevatedButton("Fees",Icons.monetization_on_outlined),
          _getElevatedButton("Library Management",Icons.library_books_outlined)
        ],
      ),
    );
  }

  Widget _getElevatedButton(String text,IconData icon) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.indigo),
      width: 290,
      child: ListTile(
        leading: Icon(icon,color: Colors.black,),
        title: Text(text,style: TextStyle(fontWeight: FontWeight.w600),),
      ),
    );
  }
}
