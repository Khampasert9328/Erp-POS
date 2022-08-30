import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ERPdate extends StatefulWidget {
  const ERPdate({Key? key}) : super(key: key);

  @override
  State<ERPdate> createState() => _ERPdateState();
}

TextEditingController _dateStart = TextEditingController();
String date = '';
String day = '';
String clock = '';
TimeOfDay? time = TimeOfDay(hour: 10, minute: 30);

class _ERPdateState extends State<ERPdate> {
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
                      primary: ERPTheme.BASE_COLOR, // header background color
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
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              color: ERPTheme.GREY_COLOR,
              borderRadius: BorderRadius.circular(
                5.r,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  ERPImages.datetime,
                  width: 30.w,
                  height: 30.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: date == ''
                          ? Text(
                              "ຈອງໂຕະ",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : Text(
                              date,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                    day == ''
                        ? Text(
                            "ມື້",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Text(
                            day,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey,
                            ),
                          )
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
