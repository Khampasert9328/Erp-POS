import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShowLoading extends StatefulWidget {
  String title;
  ShowLoading({super.key, required this.title});

  @override
  State<ShowLoading> createState() => _ShowLoadingState();
}

class _ShowLoadingState extends State<ShowLoading> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 200.h,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 10))
                    ]),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitFadingCircle(
                        color: AppTheme.BASE_COLOR,
                        size: 50,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(widget.title)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
