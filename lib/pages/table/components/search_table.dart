import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          color: AppTheme.GREY_COLOR,
          border: Border.all(color: AppTheme.WHITE_COLOR),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
          ),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'ຄົ້ນຫາໂຕະ',
                hintStyle: TextStyle(
                  fontFamily: 'Phetsarath-OT',
                  fontSize: 15.sp,
                )),
          ),
        ),
      ),
    );
  }
}
