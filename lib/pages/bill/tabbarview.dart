import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/bill/reportbill/bill_eat_at_resturant.dart';
import 'package:erp_pos/pages/bill/reportbill/bill_order_to_back_home.dart';
import 'package:erp_pos/pages/table/components/textdatetime.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:erp_pos/utils/loading.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BillBody extends StatefulWidget {
  const BillBody({super.key});

  @override
  State<BillBody> createState() => _BillBodyState();
}

class _BillBodyState extends State<BillBody> {
  DateTime? _dateTime;
  DateTime dateTimenow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2001),
                                  lastDate: DateTime(2025))
                              .then((value) {
                            setState(() {
                              _dateTime = value;
                              var str = "$_dateTime";
                              var parts = str.split(' ');
                              var prefix = parts[0].trim(); // prefix: "date"
                              var rmDash = prefix.replaceAll('-', '');
                              CountPre().setDateTime(rmDash);

                              context
                                  .read<GetOrderByIssueDateProvider>()
                                  .getorderfromservice(context);
                            });
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppTheme.BASE_COLOR),
                          child: Text(
                            "ເລືອກວັນທີ",
                            style: TextStyle(
                                fontFamily: 'Phetsarath-OT',
                                fontSize: 15.sp,
                                color: AppTheme.WHITE_COLOR,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "ວັນທີ: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              fontFamily: 'Phetsarath-OT',
                            ),
                          ),
                          Text(
                            _dateTime == null
                                ? DateFormat('dd-MM-yyyy').format(dateTimenow)
                                : DateFormat('dd-MM-yyyy').format(_dateTime!),
                            style: TextStyle(
                                fontFamily: 'Phetsarath-OT',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TabBar(
              indicatorPadding: EdgeInsets.only(left: 20.0, right: 20.0),
              indicatorWeight: 3.0,
              indicatorColor: AppTheme.BASE_COLOR,
              labelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'Phetsarath-OT',
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
