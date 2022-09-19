import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class paycash extends StatelessWidget {
  final tablename;
  const paycash({Key? key, required this.tablename}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.WHITE_COLOR,
        elevation: 0,
        title: Text(
          tablename,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ຈ່່າຍເງິນສົດ",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 60.h,
                decoration: BoxDecoration(
                    color: AppTheme.GREY_COLOR,
                    borderRadius: BorderRadius.circular(10)),
                child: const TextField(
                 keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'ລາຄາລວມ:',
                    labelStyle: TextStyle(
                      fontSize: 15,
                    ),
                  
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "ເງິນທີ່ໄດ້ຮັບ",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 60.h,
                decoration: BoxDecoration(
                    color: AppTheme.GREY_COLOR,
                    borderRadius: BorderRadius.circular(10)),
                child: const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'ປ້ອນຂໍ້ມູນ:',
                      labelStyle: TextStyle(
                        fontSize: 15,
                      ),
                      prefixText: 'ກີບ'),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    "ເງິນທອນ:",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(
                    "30000 ກີບ",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
