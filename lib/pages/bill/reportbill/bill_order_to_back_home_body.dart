import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyOfBillOrderToBackHome extends StatefulWidget {
  const BodyOfBillOrderToBackHome({super.key});

  @override
  State<BodyOfBillOrderToBackHome> createState() =>
      _BodyOfBillOrderToBackHomeState();
}

class _BodyOfBillOrderToBackHomeState extends State<BodyOfBillOrderToBackHome> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
      return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: 81.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Image.asset(
                  ERPImages.bill,
                  height: 58.h,
                  width: 58.w,
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      "ໃບບິນເລກທີ 5651",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppTheme.BASE_COLOR,
                      ),
                    ),
                    subtitle: Text("ຈ່າຍແລ້ວ"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            ERPImages.iconforbill,
                            height: 9.h,
                            width: 18.w,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
      
    },);
  }
}
