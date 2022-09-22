import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/bill/reportbill/bill_eat_at_resturant.dart';
import 'package:erp_pos/pages/bill/reportbill/bill_order_to_back_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillBody extends StatelessWidget {
  const BillBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: Center(
        child: Column(
          children: [
             TabBar(
                indicatorPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                indicatorWeight: 3.0,
                indicatorColor: AppTheme.BASE_COLOR,
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 18.sp,
                ),
                tabs: const [
                  Tab(
                    text: 'ໃບບິນກິນຢູ່ຮ້ານ',
                  ),
                  Tab(
                    text: 'ໃບບິນສັ່ງກັບບ້ານ',
                  ),
                ],
              ),

              const Expanded(
                  child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  BillEatAtResturant(),
                  BillOrderToBackHome(),
                ],
              ))
          ],
        ),
      )),
    );
  }
}
