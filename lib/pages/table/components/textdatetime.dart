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
TimeOfDay? time = TimeOfDay(hour: 10, minute: 30);
bool datetime = true;


class _ERPdateTimeState extends State<ERPdateTime> {
  @override
  Widget build(BuildContext context) {
    final hours = time!.hour.toString().padLeft(2, '0');
    final minute = time!.minute.toString().padLeft(2, '0');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context, //context of current state
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppTheme.BASE_COLOR, // header background color
                      // onPrimary: Colors.black, // header text color
                      // onSurface: Colors.green, // body text color
                    ),
                    // textButtonTheme: TextButtonThemeData(
                    //   style: TextButton.styleFrom(
                    //     primary: Colors.red, // button text color
                    //   ),
                    // ),
                  ),
                  child: child!,
                );
              },
            );

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              String formattedDay = DateFormat.E().format(pickedDate);
              print('Picked date: $formattedDate');
              setState(() {
                date = formattedDate;
                day = formattedDay;
              });
            } else {
              print("Date is not selected");
            }
          },
          child: Container(
            
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
                        date,
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      day,
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          onTap: () async {
            TimeOfDay? newTime = await showTimePicker(
              context: context,
              initialTime: time!,
            );
            if (time != null) {
              setState(() {
              time = newTime;
            });
            } else {
                 print("Date is not selected");
            }
            
            
          },
          child: Container(
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
        ),
      ],
    );
  }
}
