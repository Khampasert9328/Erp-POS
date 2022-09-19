import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/widget/paycash_detail.dart';
import 'package:erp_pos/widget/paymentbybcel.dart';
import 'package:erp_pos/widget/paymentbymoney.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentBody extends StatefulWidget {
  final tablename;
  const PaymentBody({Key? key, required this.tablename}) : super(key: key);

  @override
  State<PaymentBody> createState() => _PaymentBodyState();
}

class _PaymentBodyState extends State<PaymentBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => paycash(
                            tablename: widget.tablename,
                          )));
            },
            child: Container(
              height: 81.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppTheme.GREY_COLOR,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Image.asset(
                    ERPImages.meney,
                    height: 63.h,
                    width: 69.w,
                  ),
                  Text(
                    "ຈ່າຍດ້ວຍສົດ",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: AppTheme.BASE_COLOR,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentBcelone(tablename: widget.tablename),
                ),
              );
            },
            child: Container(
              height: 81.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppTheme.GREY_COLOR,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Image.asset(
                    ERPImages.bcelone,
                    height: 63.h,
                    width: 69.w,
                  ),
                  Text(
                    "ຈ່າຍດ້ວຍ BCEL One",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: AppTheme.BASE_COLOR,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentMmoney(
                    tablename: widget.tablename,
                  ),
                ),
              );
            },
            child: Container(
              height: 81.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppTheme.GREY_COLOR,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Image.asset(
                    ERPImages.mmoney,
                    height: 63.h,
                    width: 69.w,
                  ),
                  Text(
                    "ຈ່າຍດ້ວຍ M-money",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: AppTheme.BASE_COLOR,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
