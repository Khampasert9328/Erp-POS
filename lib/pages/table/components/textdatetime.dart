import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ERPdateTime extends StatefulWidget {
  const ERPdateTime({Key? key}) : super(key: key);

  @override
  State<ERPdateTime> createState() => _ERPdateTimeState();
}

TextEditingController _dateStart = TextEditingController();
String date = '';
String day = '';
String clock = '';
TimeOfDay? time = TimeOfDay.now();
bool datetime = true;
String date1 = DateFormat('dd-MM-yyyy').format(DateTime.now());
String day1 = DateFormat.E().format(DateTime.now());


class _ERPdateTimeState extends State<ERPdateTime> {
  @override
  Widget build(BuildContext context) {
    final hours = time!.hour.toString().padLeft(2, '0');
    final minute = time!.minute.toString().padLeft(2, '0');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Container(
            
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppTheme.GREY_COLOR,
              borderRadius: BorderRadius.circular(
                5.r,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  ERPImages.datetime,
                  width: 30.w,
                  height: 30.h,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        date1,
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      day1,
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ),
        
        SizedBox(
          width: 10.w,
        ),
        Container(
            //width: 150,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppTheme.GREY_COLOR,
              borderRadius: BorderRadius.circular(
                5.r,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  ERPImages.clock,
                  width: 30.w,
                  height: 30.h,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        '$hours:$minute',
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        
      ],
    );
  }
}
