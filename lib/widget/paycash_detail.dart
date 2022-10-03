import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class paycash extends StatefulWidget {
  final tablename;
  paycash({Key? key, required this.tablename}) : super(key: key);

  @override
  State<paycash> createState() => _paycashState();
}

class _paycashState extends State<paycash> {
  TextEditingController money = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int? totalamount = context.read<GetFoodMenuProvider>().totalamont;
    String myMoney = money.text.replaceAll(',', '');
    int sumall = 0;
    if(myMoney.isNotEmpty){
      sumall = int.parse(myMoney) - totalamount;
    }
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
              onPressed: () {},
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
              TextEditingController? payment = TextEditingController();
              payment.text = value.totalamont.toString();

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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffedebeb),
                        border: InputBorder.none,
                        hintText: 'ລາຄາລວມ',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 15, right: 5),
                          child: Text(
                            '${context.read<GetFoodMenuProvider>().totalamont} ກີບ',
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
                      controller: money,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffedebeb),
                        border: InputBorder.none,
                        hintText: 'ປ້ອນຂໍ້ມູນ:',
                        hintStyle: TextStyle(
                            fontFamily: "NotoSansLao-Regular",
                            fontSize: 18.sp,
                            color: AppTheme.BASE_COLOR),
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
                          " ກີບ",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
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
