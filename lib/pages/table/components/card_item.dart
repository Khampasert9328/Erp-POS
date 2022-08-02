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
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    id,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: ERPTheme.GREY_COLOR,
              border: Border(
                left: BorderSide(
                  color: color,
                  width: 10.w,
                ),
              ),
              //borderRadius: BorderRadius.circular(5),
            ),
          ),
          
        ],
      ),
    );
  }
}
