import 'package:erp_management/database/fees_database.dart';
import 'package:erp_management/database/users_database.dart';
import 'package:erp_management/pages/home/ui/home.dart';
import 'package:flutter/material.dart';

void main() {
  UsersDatabaseHelper();
  FeesDatabaseHelper();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.indigo,
        useMaterial3: false
      ),
      home: const Home(),
    );
  }
}
