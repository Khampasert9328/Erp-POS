import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/table/components/buttom_dialog.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/images.dart';

class NavBarStatusBooking extends StatefulWidget {
  const NavBarStatusBooking({Key? key}) : super(key: key);

  @override
  State<NavBarStatusBooking> createState() => _NavBarStatusBookingState();
}

class _NavBarStatusBookingState extends State<NavBarStatusBooking> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
              Text(
                "00 ວ່າງ",
                style: TextStyle(
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10.w,
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
              Text(
                "00 ຈອງແລ້ວ",
                style: TextStyle(
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
