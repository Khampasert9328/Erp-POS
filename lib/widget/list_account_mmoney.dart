import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/getaccount/getaccount_models.dart';
import 'package:erp_pos/model/ordertable/order_table_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/provider/generateqrmmoney/generate_qr_mmoney_provider.dart';
import 'package:erp_pos/provider/getaccount/getaccount_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ListAccountMmoney extends StatelessWidget {
  String tablename;
  ListAccountMmoney({
    required this.tablename,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 300.w,
      child: FutureBuilder<List<Payment>?>(
        future: context.read<GetAccountProvider>().getAccountProvider(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<GetAccountProvider>(
              builder: ((context, model, _) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data![index].accounttype != 4) {
                        return Container();
                      }
                      return Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: (() async {
                              String? tablename =
                                  await CountPre().getTableName();
                              String? tableid = await CountPre().getTableId();
                              String? areaid = await CountPre().getAreaId();
                              String? areaname = await CountPre().getArea();

                              // ignore: use_build_context_synchronously
                              context
                                  .read<GenerateQrMmoneyProvider>()
                                  .getqrmmoney(
                                    context,
                                    snapshot.data![index].accountnumber!,
                                    snapshot.data![index].merchid!,
                                    areaname!,
                                    areaid!,
                                    tableid!,
                                    tablename!,
                                  );
                            }),
                            child: Container(
                              height: 50.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppTheme.GREY_COLOR,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 50.w,
                                    child: Image.asset(ERPImages.mmoney),
                                  ),
                                  Text(
                                    snapshot.data![index].merchname!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              }),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: AppTheme.BASE_COLOR,
            ),
          );
        },
      ),
    );
  }
}
