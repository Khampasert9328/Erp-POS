import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/getorderbyissuedate/get_order_by_isuedatemodels.dart';
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
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetOrder>?>(
      future: GetOrderByIssueDateProvider().getorderfromservice(),
      builder: (context, snapshot) {
        print("snapshot:$snapshot");
        if (snapshot.hasData) {  
          return Consumer<GetOrderByIssueDateProvider>(
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
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
                                    "${snapshot.data!.first.issuedate}",
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
                },
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
