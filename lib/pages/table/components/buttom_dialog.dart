import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/theme.dart';

class ButtomDialog extends StatelessWidget {
  VoidCallback onPressed;
  String text;

  ButtomDialog({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppTheme.BASE_COLOR,
            padding: EdgeInsets.symmetric(vertical: 9.h),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "Phetsarath-OT",
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
