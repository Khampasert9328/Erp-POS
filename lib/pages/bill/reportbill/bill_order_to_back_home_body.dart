import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
import 'package:erp_pos/pages/bill/detail/body_detail_bill.dart';
import 'package:erp_pos/pages/bill/reportbill/detail_order_back_home.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:erp_pos/provider/gettableall/get_table_all_provider.dart';
import 'package:erp_pos/utils/check_color.dart';
import 'package:erp_pos/utils/check_status.dart';
import 'package:erp_pos/utils/check_status_bill.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
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
  void initState() {
    context.read<GetOrderByIssueDateProvider>().getorderfromservice(context);
    context.read<GetTableAllProvider>().gettableall(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GetOrderByIssueDateProvider, GetTableAllProvider>(
      builder: ((context, value, table, _) {
        //ຖ້າມັນໂຫຼດຢູ່
        if (value.isloading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          //ໃນກໍລະນີ API ເກີດຂໍ້ຜິດພາດບາງຢ່າງ
          if (value.getOrderByListId == null || value.order == null) {
            return const Center(
              child: Text(
                "ບໍ່ມີຂໍ້ມູນໃບບິນສັ່ງກັບບ້ານ",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Phetsarath-OT',
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: value.order!.order!.length,
              itemBuilder: (context, index) {
                String prefix = '';
                String status;
                String? tablename = '';
                Color? cl;

                if (value.order!.order![index].tableid != "none") {
                  return const SizedBox();
                } else {
                  tablename = 'ສັ່ງກັບບ້ານ';
                  status = checkstatus1(value.order!.order![index].status!);
                  cl = checkcolor(value.order!.order![index].status!);
                }

                for (var data in value.getOrderByListId!.bill!) {
                  if (value.billid == data.id) {
                    prefix = data.prefixid!;
                  }
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<SetData>().setOrderbill(false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BodyDetailBill(
                                date: value.order!.order![index].date!,
                                tablename: tablename!,
                                billid: value.order!.order![index].billid!,
                                orderid: value.order!.order![index].id!,
                                tableid: value.order!.order![index].tableid!,
                                status: value.order!.order![index].status!,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 81.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 4.h,
                                      width: 42.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppTheme.BASE_COLOR),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 26.h,
                                          width: 4.w,
                                          decoration: BoxDecoration(
                                              //  color: AppTheme.GREEN_COLOR,
                                              border: Border.all(
                                                  color: AppTheme.BASE_COLOR),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        SizedBox(
                                          width: 2.h,
                                        ),
                                        Container(
                                          height: 36.h,
                                          width: 57.w,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppTheme.BASE_COLOR),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              tablename,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontFamily: 'Phetsarath-OT',
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.h,
                                        ),
                                        Container(
                                          height: 26.h,
                                          width: 4.w,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppTheme.BASE_COLOR),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Container(
                                      height: 4.h,
                                      width: 42.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppTheme.BASE_COLOR),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    "ໂຕະ $tablename",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily: 'Phetsarath-OT',
                                        color: AppTheme.BASE_COLOR,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "# Order $prefix",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppTheme.BASE_COLOR,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 35.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                          color: cl,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Text(
                                          status.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Phetsarath-OT',
                                            color: AppTheme.WHITE_COLOR,
                                          ),
                                        ),
                                      ),
                                    ),
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
          }
        }
      }),
    );
  }
}
