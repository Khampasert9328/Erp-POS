import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
import 'package:erp_pos/pages/bill/reportbill/detail_order_back_home.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BodyOfBillOrderToBackHome extends StatefulWidget {
  const BodyOfBillOrderToBackHome({super.key});

  @override
  State<BodyOfBillOrderToBackHome> createState() =>
      _BodyOfBillOrderToBackHomeState();
}

class _BodyOfBillOrderToBackHomeState extends State<BodyOfBillOrderToBackHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetOrderByIssueDateProvider>(
        builder: ((context, value, child) {
      return ListView.builder(
        itemCount: value.order!.totalcount,
        itemBuilder: (context, index) {
          // if (value.order!.order![index].tableid != 'none') {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (() {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailOrderBackHome(data: value.order!.order![index], index: index,)));
                  }),
                  child: Container(
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
                              value.order!.order![index].billid!,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppTheme.BASE_COLOR,
                              ),
                            ),
                            subtitle: const Text("ຈ່າຍແລ້ວ"),
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
                ),
              ],
            ),
          );
        },
      );
    }));
  }
}
