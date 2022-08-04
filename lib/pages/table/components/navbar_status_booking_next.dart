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
                radius: 17,
                child: Image.asset(
                  POSImages.tableStatus,
                  height: 17.h,
                  width: 17.w,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                "00 ວ່າງ",
                style: TextStyle(
                  fontFamily: "Phetsarath-OT",
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Container(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: ERPTheme.BLUE_COLOR,
                radius: 17,
                child: Image.asset(
                  POSImages.tableStatus,
                  height: 17.h,
                  width: 17.w,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                "00 ຈອງແລ້ວ",
                style: TextStyle(
                  fontFamily: "Phetsarath-OT",
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
