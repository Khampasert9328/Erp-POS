// ignore_for_file: sort_child_properties_last

import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/table/components/detail_table.dart';
import 'package:erp_pos/pages/table/components/models/card_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardItem extends StatelessWidget {
  String id;
  String title;
  Color color;
  CardItem({
    required this.title,
    required this.color,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailTable(
              title: title,
              color: color,
              id: id,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            color: ERPTheme.GREY_COLOR,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  id,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
