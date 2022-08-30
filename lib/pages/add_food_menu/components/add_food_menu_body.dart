import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddFoodMenuBody extends StatelessWidget {
  AddFoodMenuBody({Key? key}) : super(key: key);

  TextEditingController foodID = TextEditingController();
  TextEditingController restaurantName = TextEditingController();
  TextEditingController foodDetail = TextEditingController();
  TextEditingController sellingPrice = TextEditingController();
  TextEditingController purchasePrice = TextEditingController();
  TextEditingController smallSize = TextEditingController();
  TextEditingController mediumSize = TextEditingController();
  TextEditingController largeSize = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text.rich(TextSpan(
              text: 'ປະເພດອາຫານ: ',
              style: TextStyle(fontSize: 15.sp, color: ERPTheme.BASE_COLOR),
              children: <InlineSpan>[
                TextSpan(
                  text: 'ປະເພດອາຫານຝຣັ່ງ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ])),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'ລະຫັດ',
            style: TextStyle(fontSize: 15.sp, color: ERPTheme.BASE_COLOR),
          ),
          buildTextField(foodID, 1, false),
          SizedBox(
            height: 7.h,
          ),
          Text(
            'ຊື່ອາຫານ',
            style: TextStyle(fontSize: 15.sp, color: ERPTheme.BASE_COLOR),
          ),
          buildTextField(restaurantName, 1, false),
          SizedBox(
            height: 7.h,
          ),
          Text(
            'ລາຍລະອຽດອາຫານ',
            style: TextStyle(fontSize: 15.sp, color: ERPTheme.BASE_COLOR),
          ),
          buildTextField(foodDetail, 5, false),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'ລາຄາຂາຍ',
            style: TextStyle(fontSize: 15.sp, color: ERPTheme.BASE_COLOR),
          ),
          buildTextField(sellingPrice, 1, true),
          SizedBox(
            height: 7.h,
          ),
          Text(
            'ລາຄາຊື້',
            style: TextStyle(fontSize: 15.sp, color: ERPTheme.BASE_COLOR),
          ),
          buildTextField(purchasePrice, 1, true),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'ລະດັບລາຄາຕາມຂະໜາດ (Optional)',
            style: TextStyle(fontSize: 15.sp, color: ERPTheme.BASE_COLOR),
          ),
          SizedBox(
            height: 7.h,
          ),
          buildLevelSizeofPrice('ນ້ອຍ(S)', smallSize),
          SizedBox(
            height: 7.h,
          ),
          buildLevelSizeofPrice('ກາງ(M)', mediumSize),
          SizedBox(
            height: 7.h,
          ),
          buildLevelSizeofPrice('ໃຫຍ່(L)', largeSize),
          SizedBox(
            height: 30.h,
          ),
          Row(
            children: [
              buildButton('ຍົກເລີກ', Color(0xFFFFFFFF), Color(0xFF999DAA)),
              SizedBox(
                width: 20.w,
              ),
              buildButton('ເພີ່ມ', ERPTheme.BASE_COLOR, Color(0xFFFFFFFF)),
            ],
          ),
          SizedBox(
            height: 50.h,
          )
        ],
      )),
    );
  }

  Expanded buildButton(String title, Color backgroundColor, Color fontColor) {
    return Expanded(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                primary: backgroundColor),
            onPressed: () {},
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: fontColor,
                  fontWeight: FontWeight.w700),
            )));
  }

  Row buildLevelSizeofPrice(String title, TextEditingController controller) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            title,
            style: TextStyle(fontSize: 12.sp, color: ERPTheme.BASE_COLOR),
          ),
        ),
        Expanded(child: buildTextField(controller, 1, true)),
      ],
    );
  }

  Container buildTextField(
      TextEditingController controller, int maxLines, bool showCurrency) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Color(0xFFF4F5F6),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: maxLines,
              controller: controller,
              style: TextStyle(fontSize: 16.sp),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'ປ້ອນຂໍ້ມູນ',
              ),
            ),
          ),
          if (showCurrency)
            Text(
              'ກີບ',
              style: TextStyle(fontSize: 12.sp, color: Colors.black),
            )
        ],
      ),
    );
  }
}
