import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/widget/erp_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void addOnDialog(BuildContext context){
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  showDialog(context: context, builder: (_){
    return Dialog(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ເພີ່ມຕື່ມ', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: AppTheme.BASE_COLOR),),
              SizedBox(height: 7.h,),
              Text('ຊື່',style: TextStyle(fontSize: 18.sp,color: AppTheme.BASE_COLOR)),
              SizedBox(height: 5.h,),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF4F5F6)
                ),
                child: ERPTextfield(controller: name, hintText: ''),
              ),
              SizedBox(height: 20.h,),
              Text('ລາຄາ',style: TextStyle(fontSize: 18.sp,color: AppTheme.BASE_COLOR)),
              SizedBox(height: 5.h,),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF4F5F6)
                ),
                child: ERPTextfield(controller: amount, hintText: ''),
              ),
              SizedBox(height: 30.h,),
              Row(
                children: [
                  buildButton('ຍົກເລີກ', Color(0xFFFFFFFF), Color(0xFF999DAA), (){
                    Navigator.pop(context);
                  }),
                  SizedBox(
                    width: 20.w,
                  ),
                  buildButton('ເພີ່ມ', AppTheme.BASE_COLOR, Color(0xFFFFFFFF), (){}),
                ],
              ),
              SizedBox(height: 50.h,)
            ],
          ),
        ),
      ),
    );
  });

}

Expanded buildButton(String title, Color backgroundColor, Color fontColor, VoidCallback onPressed) {
  return Expanded(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)
              ),
              primary: backgroundColor),
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 18.sp,
                color: fontColor,
                fontWeight: FontWeight.w700),
          )));
}