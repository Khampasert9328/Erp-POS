import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/table/components/buttom_dialog.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/images.dart';

class NavBarStatus extends StatefulWidget {
  const NavBarStatus({Key? key}) : super(key: key);

  @override
  State<NavBarStatus> createState() => _NavBarStatusState();
}

class _NavBarStatusState extends State<NavBarStatus> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
             CircleAvatar(
                  backgroundColor: ERPTheme.GREEN_COLOR,
                  radius: 15,
                  child: Image.asset(
                    POSImages.tableStatus,
                    height: 15.h,
                    width: 15.w,
                  ),
                ),
            
              SizedBox(
                width: 5.w,
              ),
              Text("00 ວ່າງ"),
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: ERPTheme.RED_COLOR,
                radius: 15,
                child: Image.asset(
                  POSImages.tableStatus,
                  height: 15.h,
                  width: 15.w,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text("00 ບໍ່ວ່າງ"),
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: ERPTheme.PINK_COLOR,
                radius: 15,
                child: Image.asset(
                  POSImages.tableStatus,
                  height: 15.h,
                  width: 15.w,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text("00 ຈອງແລ້ວ"),
            ],
          ),
        ),
      ],
    );
  }

}