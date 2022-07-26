import 'package:erp_pos/pages/table/components/table_body.dart';
import 'package:flutter/material.dart';

class Table extends StatefulWidget {
  const Table({Key? key}) : super(key: key);

  @override
  State<Table> createState() => _TableState();
}

class _TableState extends State<Table> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableBody(),
    );
  }
}
