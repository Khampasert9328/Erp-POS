import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';

class SearchTable extends StatefulWidget {
  const SearchTable({Key? key}) : super(key: key);

  @override
  State<SearchTable> createState() => _SearchTableState();
}

class _SearchTableState extends State<SearchTable> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: ERPTheme.GREY_COLOR,
          border: Border.all(color: ERPTheme.WHITE_COLOR),
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
          padding: EdgeInsets.only(
            left: 20.0,
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'ຄົ້ນຫາໂຕະ',
            ),
          ),
        ),
      ),
    );
  }
}