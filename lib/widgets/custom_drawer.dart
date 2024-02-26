import 'package:erp_management/pages/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(this._bloc,{super.key});
  final HomeBloc _bloc;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(onTap:(){
            _bloc.add(NewUserEvent());
          },child:_getElevatedButton("Create New User")),
          _getElevatedButton("Update User Details"),
        _getElevatedButton("Fees"),
    _getElevatedButton("Library Management")
        ],
      ),
    );
  }


  Widget _getElevatedButton(String text) {
    return Container(
      padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
      width: 290,
      child: Card(
        elevation: 3,
        color: Colors.deepPurple.shade300,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Center(child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(text,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
        )),
      ),
    );
  }

}




