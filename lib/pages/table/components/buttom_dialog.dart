import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/theme.dart';

class ButtomDialog extends StatefulWidget {
  const ButtomDialog({Key? key}) : super(key: key);

  @override
  State<ButtomDialog> createState() => _ButtomDialogState();
}

class _ButtomDialogState extends State<ButtomDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "ຍົກເລີກ",
              style: TextStyle(
                color: ERPTheme.GREY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 120.w,
            height: 39.h,
            decoration: BoxDecoration(
              color: ERPTheme.BASE_COLOR,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "ຕົກລົງ",
                style: TextStyle(
                  color: ERPTheme.WHITE_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
