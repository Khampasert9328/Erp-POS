import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void addFoodTypeDialog(BuildContext context) {
  TextEditingController controller = TextEditingController();
  showDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ຊື່ປະເພດອາຫານ',
                    style: TextStyle(
                        color: ERPTheme.BASE_COLOR,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(color: Color(0xFFF4F5F6)),
                    child: TextField(
                      controller: controller,
                      style: TextStyle(fontSize: 14.sp),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ປ້ອນຂໍ້ມູນ',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 5.h)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'ຍົກເລີກ',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF999DAA)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: ERPTheme.BASE_COLOR,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.w, vertical: 5.h)),
                          onPressed: () {},
                          child: Text(
                            'ເພີ່ມ',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
