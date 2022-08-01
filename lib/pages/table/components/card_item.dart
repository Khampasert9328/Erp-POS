// ignore_for_file: sort_child_properties_last

import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/table/components/detail_table.dart';
import 'package:erp_pos/pages/table/components/models/card_models.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
   String title;
   Color color;
  CardItem({required this.title,required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailTable(title: title, color: color),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Text(title),
        ),
        decoration: BoxDecoration(
          color: ERPTheme.GREY_COLOR,
          border:  Border(
            left: BorderSide(
              color: color,
              width: 5.0,
            ),
          ),
          //borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
