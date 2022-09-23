import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ERPTabbarView extends StatefulWidget {
  const ERPTabbarView({Key? key}) : super(key: key);

  @override
  State<ERPTabbarView> createState() => _ERPTabbarViewState();
}

class _ERPTabbarViewState extends State<ERPTabbarView> {
  List<String> item = [
    'ສະຖານະປັດຈຸບັນ',
    'ຈອງລ່ວງໜ້າ',
  ];
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: item.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item[index],
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: selectIndex == index
                            ? AppTheme.BLACK_COLOR
                            : AppTheme.GREY_COLOR),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    width: 100.w,
                    height: 5.h,
                    color: selectIndex == index
                        ? AppTheme.BLACK_COLOR
                        : Colors.transparent,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
