import 'package:erp_pos/pages/Dasboard/dasboard.dart';
import 'constant/routes.dart' as custom_route;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: custom_route.Route.getAll(),
      home: Dasboard(),
    );
  }
}