import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/foodmenu/food_menu_models.dart';
import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
import 'package:erp_pos/pages/bill/detail/body_detail_bill.dart';
import 'package:erp_pos/pages/bill/reportbill/detail_order_back_home.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:erp_pos/provider/gettableall/get_table_all_provider.dart';
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
              child: Text("ເກີດຂໍ້ຜິດພາດ"),
            );
          } else {
            return ListView.builder(
              itemCount: value.order!.order!.length,
              itemBuilder: (context, index) {
                String tablename = 'ສັ່ງກັບບ້ານ';
                String prefix = '';
                for (var data in table.tableModels!.table!) {
                  if (value.order!.order![index].tableid == data.id) {
                   tablename = data.name!;
                  }
                }
                for (var data in value.getOrderByListId!.bill!) {
                  if (value.billid == data.id) {
                    prefix = data.prefixid!;
                  }
                }

                return Consumer<GetTableAllProvider>(
                    builder: ((context, model, child) {
                  if (model.isloading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return model.tableModels! == null
                      ? const Center(
                          child: Text("ບໍ່ມີຂໍ້ມູນ"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BodyDetailBill(
                                            data: value.order!.order![index]
                                                .product!)),
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
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 4.h,
                                              width: 42.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          AppTheme.BASE_COLOR),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
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
                                                          color: AppTheme
                                                              .BASE_COLOR),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                SizedBox(
                                                  width: 2.h,
                                                ),
                                                Container(
                                                  height: 36.h,
                                                  width: 57.w,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppTheme
                                                              .BASE_COLOR),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: Text("$tablename"),
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
                                                          color: AppTheme
                                                              .BASE_COLOR),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
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
                                                      color:
                                                          AppTheme.BASE_COLOR),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            "ໂຕະ ${tablename}",
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                color: AppTheme.BASE_COLOR,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            "# Order ${prefix}",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: AppTheme.BASE_COLOR,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Image.asset(
                                                ERPImages.iconforbill,
                                                height: 9.h,
                                                width: 18.w,
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
                }));
              },
            );
          }
        }
      }),
    );
  }
}
