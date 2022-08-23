
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/theme.dart';

class SelectedMenuCardExpand extends StatelessWidget {
  VoidCallback onNext;
  ScrollController scrollController;

  SelectedMenuCardExpand({required this.onNext, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Expanded(
              child: ListView(
                controller: scrollController,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.h, vertical: 15.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.r),
                            topLeft: Radius.circular(15.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ລາຍການອາຫານ',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: ERPTheme.BASE_COLOR),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text.rich(TextSpan(
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: ERPTheme.BASE_COLOR),
                                    text: 'ລວມລາຄາ: ',
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: ' 70.000 ກີບ',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: ERPTheme.BASE_COLOR,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]))
                              ],
                            ),
                            Icon(
                              Icons.shopping_cart,
                              size: 55,
                            )
                          ],
                        ),
                      ),
                      //SelectedMenuCardExpand(onNext: onNext, scrollController: scrollController)
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              decoration: BoxDecoration(color: Color(0xFFF4F5F6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_cart,
                            size: (30.w + 30.h) / 2,
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'ລວມລາຄາ:',
                        style: TextStyle(
                            fontSize: 15.sp, color: ERPTheme.BASE_COLOR),
                      )
                    ],
                  ),
                  Text('70,000 ກີບ',style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700, fontSize: 15.sp),)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30.w), primary: ERPTheme.BASE_COLOR),
                    onPressed: onNext,
                    child: Text(
                      'ຕໍ່ໄປ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700
                      ),
                    )),
                    SizedBox(width: 20.w,)
              ],
            )
          ],
        );
  }
}