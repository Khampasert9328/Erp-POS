import 'package:erp_pos/pages/Dasboard/dasboard.dart';
import 'package:erp_pos/pages/login/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dasboard(),
    );
  }
}