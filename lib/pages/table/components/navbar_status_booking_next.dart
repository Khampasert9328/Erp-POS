import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/pages/table/components/buttom_dialog.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/images.dart';

class NavBarStatusBooking extends StatefulWidget {
  NavBarStatusBooking({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBarStatusBooking> createState() => _NavBarStatusBookingState();
}

class _NavBarStatusBookingState extends State<NavBarStatusBooking> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppTheme.GREEN_COLOR,
                radius: 15,
                child: Image.asset(
                  ERPImages.tableStatus,
                  height: 15.h,
                  width: 15.w,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "00 ຫວ່າງ",
                style: TextStyle(
                  fontFamily: 'Phetsarath-OT',
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 6.w,
        ),
        Container(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppTheme.RED_COLOR,
                radius: 15,
                child: Image.asset(
                  ERPImages.tableStatus,
                  height: 15.h,
                  width: 15.w,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "00 ບໍ່ຫວ່າງ",
                style: TextStyle(
                  fontFamily: 'Phetsarath-OT',
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppTheme.PINK_COLOR,
                radius: 15,
                child: Image.asset(
                  ERPImages.tableStatus,
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
                  fontFamily: 'Phetsarath-OT',
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
