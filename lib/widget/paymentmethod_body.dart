import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/provider/generateqrmmoney/generate_qr_mmoney_provider.dart';
import 'package:erp_pos/widget/list_account_bcelone.dart';
import 'package:erp_pos/widget/list_account_mmoney.dart';
import 'package:erp_pos/widget/paycash_detail.dart';
import 'package:erp_pos/widget/paymentbybcel.dart';
import 'package:erp_pos/widget/paymentbymoney.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PaymentBody extends StatefulWidget {
  GetTable datatable;
  String id;
  String areaname;
  String tablename;
  List<Product>? data;
  int tatal;
  PaymentBody(
      {Key? key,
      required this.tablename,
      required this.data,
      required this.datatable,
      required this.id,
      required this.areaname,
      required this.tatal
      })
      : super(key: key);

  @override
  State<PaymentBody> createState() => _PaymentBodyState();
}

class _PaymentBodyState extends State<PaymentBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => paycash(
                            data: widget.data,
                            tablename: widget.tablename,
                            datatable: widget.datatable,
                            id: widget.id,
                            areaname: widget.areaname,
                            tatal: widget.tatal,
                          )));
            },
            child: Container(
              height: 81.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Row(
                  children: [
                    Image.asset(
                      ERPImages.meney,
                      height: 63.h,
                      width: 63.w,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      "ຈ່າຍດ້ວຍເງິນສົດ",
                      style: TextStyle(
                          fontFamily: 'Phetsarath-OT',
                          fontSize: 18.sp,
                          color: AppTheme.BASE_COLOR,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'ເລືອກບັນຊີ',
                        style: TextStyle(
                            fontFamily: 'Phetsarath-OT',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      ),
                      content: ListAccountBCELONE(
                        tablename: widget.tablename,
                        data: widget.data,
                        datatable: widget.datatable,
                        id: widget.id,
                        areaname: widget.areaname,
                      ),
                    );
                  });
            },
            child: Container(
              height: 81.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Row(
                  children: [
                    Image.asset(
                      ERPImages.onepay,
                      height: 63.h,
                      width: 63.w,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      "ຈ່າຍດ້ວຍ BCEL One",
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: AppTheme.BASE_COLOR,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Phetsarath-OT'),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'ເລືອກບັນຊີ',
                        style: TextStyle(
                            fontFamily: 'Phetsarath-OT',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      ),
                      content: ListAccountMmoney(
                        data: widget.data,
                      ),
                    );
                  });
            },
            child: Container(
              height: 81.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Row(
                  children: [
                    Image.asset(
                      ERPImages.mmoney,
                      height: 63.h,
                      width: 63.w,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      "ຈ່າຍດ້ວຍ M-money",
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: AppTheme.BASE_COLOR,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Phetsarath-OT'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
