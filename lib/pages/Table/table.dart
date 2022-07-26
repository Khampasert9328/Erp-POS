import 'package:flutter/material.dart';

class Table1 extends StatefulWidget {
  const Table1({Key? key}) : super(key: key);

  @override
  State<Table1> createState() => _Table1State();
}

class _Table1State extends State<Table1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "hiii Table",
        ),
      ),
    );
  }
}
