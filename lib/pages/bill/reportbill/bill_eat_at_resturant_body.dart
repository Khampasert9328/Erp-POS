// ignore_for_file: unused_import

import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
import 'package:erp_pos/model/getorderbylistid/get_order_by_list_id_models.dart';
import 'package:erp_pos/pages/bill/detail/bill_detail.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BilleatatresturantBody extends StatefulWidget {
  const BilleatatresturantBody({super.key});

  @override
  State<BilleatatresturantBody> createState() => _BilleatatresturantBodyState();
}

class _BilleatatresturantBodyState extends State<BilleatatresturantBody> {
  @override
  void initState() {
    super.initState();
    context.read<GetOrderByIssueDateProvider>().getorderfromservice(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetOrderByIssueDateProvider>(
      builder: ((context, value, _) {
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
              itemCount: value.order!.totalcount,
              itemBuilder: (context, index) {
                List<String> prefix = [];
                for (var i in value.getOrderByListId!.bill!) {
                  if (i.id == value.order!.order![index].billid) {
                    prefix.add(i.prefixid!);
                  }
                }
                if (prefix.length != 1) {
                  return const Text("ບໍ່ມີລາຍການ");
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BillDetail(),
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
                                                  BorderRadius.circular(10)),
                                          child: const Center(
                                            child: Text(""),
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
                                    "# Order ${prefix.first}",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppTheme.BASE_COLOR,
                                    ),
                                  ),
                                  subtitle: const Text(""),
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
