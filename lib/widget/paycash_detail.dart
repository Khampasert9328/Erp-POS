import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/paymentcash/paymentcash_models.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/paycash/paymentcash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/provider.dart';

class paycash extends StatefulWidget {
  final tablename;
  paycash({Key? key, required this.tablename}) : super(key: key);

  @override
  State<paycash> createState() => _paycashState();
}

class _paycashState extends State<paycash> {
  TextEditingController money = TextEditingController();
  ////////ວິທີການເຮັດການທ້ອນເງິນຢູ່ໜ້າ ການຈ່າຍເງິນສົດ

  int sumall = 0;
  @override
  Widget build(BuildContext context) {
    int? totalamount = context.read<GetFoodMenuProvider>().totalamont;

  
  
////////////////////////////////////////////////////////////
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppTheme.WHITE_COLOR,
          elevation: 0,
          title: Text(
            widget.tablename,
            style: TextStyle(color: AppTheme.BASE_COLOR),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            child: FloatingActionButton(
              backgroundColor: AppTheme.BASE_COLOR,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                String mmoney = money.text.replaceAll(',','');
                int intMoney = int.parse(mmoney);
                PaymentCashProvider().createpaymentcashprovider(context, intMoney);
               
              },
              child: Text(
                "ຊຳລະເງິນ",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<GetFoodMenuProvider>(
            builder: (context, value, child) {
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ຈ່່າຍເງິນສົດ",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffedebeb),
                        border: InputBorder.none,
                        hintText: 'ລາຄາລວມ',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 15, right: 5),
                          child: Text(
                            '${NumberFormat.currency(symbol: '', decimalDigits: 0).format(value.totalamont)} ກີບ',
                            style: TextStyle(color: AppTheme.RED_COLOR),
                          ),
                        ),
                        hintStyle: TextStyle(
                            fontFamily: "NotoSansLao-Regular",
                            fontSize: 18.sp,
                            color: AppTheme.BASE_COLOR),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "ເງິນທີ່ໄດ້ຮັບ",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    TextFormField(
                      inputFormatters: [ThousandsFormatter()],
                      controller: money,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        //ວິທີເຮັດ setState ການທ້ອນເງິນໃຫ້ຕົວເລກປ່ຽນ Auto
                        if (money.text.isNotEmpty) {
                          String myMoney = money.text.replaceAll(',', '');
                          int myMoney1 = int.parse(myMoney);
                          if (myMoney1 >= totalamount) {
                            setState(() {
                              sumall = myMoney1 - totalamount;
                            });
                          }
                        } else {
                          setState(() {
                            sumall = 0;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffedebeb),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontFamily: "NotoSansLao-Regular",
                            fontSize: 18.sp,
                            color: AppTheme.BASE_COLOR),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 15, right: 5),
                          child: Text(
                            'ກີບ',
                            style: TextStyle(color: AppTheme.RED_COLOR),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "ເງິນທອນ:",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          "${NumberFormat.currency(symbol: '', decimalDigits: 0).format(sumall)} ກີບ",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
            },
          ),
        ));
  }
}
