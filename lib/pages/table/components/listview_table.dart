// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, unused_import
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/table/components/buttom_dialog.dart';
import 'package:erp_pos/pages/table/components/dropdown.dart';
import 'package:erp_pos/pages/table/components/dropdown_status.dart';
import 'package:erp_pos/pages/table/components/navbar_status_booking_next.dart';
import 'package:erp_pos/pages/table_detail/components/table_detail_body.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/provider/areaprovider/insert_area_provider.dart';
import 'package:erp_pos/provider/listtable/list_table_provider.dart';
import 'package:erp_pos/provider/tableprovider/click_table_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/services/getArea/get_area.dart';
import 'package:erp_pos/utils/check_status.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:erp_pos/constant/routes.dart' as custom_route;

import '../../../constant/theme.dart';

class ListViewTable extends StatefulWidget {
  ListViewTable({
    Key? key,
  }) : super(key: key);

  @override
  State<ListViewTable> createState() => _ListViewTableState();
}

int? selectIndex = 0;
String? idtable;
String? idarea;
String? area;
int selectTable = 0;

int? statusTable;

class _ListViewTableState extends State<ListViewTable> {
  @override

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50.h,
          width: double.infinity,
          child: FutureBuilder<List<Area>>(
            future: context.read<AreaProvider>().getZone(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Consumer<AreaProvider>(
                  builder: ((context, model, _) {
                    return ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectIndex = index;
                                          idtable = snapshot.data![index].id;
                                          idarea = snapshot.data![index].id;
                                          area = snapshot.data![index].area!;
                                          CountPre().setAreaId(idarea!);
                                          CountPre().setArea(area!);

                                          print("idarea:$idarea");

                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8,
                                            ),
                                            child: Container(
                                              height: 40.h,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: selectIndex == index
                                                      ? AppTheme.BASE_COLOR
                                                      : AppTheme.WHITE_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color:
                                                          AppTheme.BASE_COLOR)),
                                              child: Center(
                                                child: Text(
                                                  snapshot.data![index].area!,
                                                  style: TextStyle(
                                                    fontFamily: 'Phetsarath-OT',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.sp,
                                                    color: selectIndex == index
                                                        ? AppTheme.WHITE_COLOR
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
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
        ),
        const NavBarStatusBooking(),
        SizedBox(
          height: 10.h,
        ),
        Expanded(
          child: FutureBuilder<List<GetTable>>(
            future:
                context.read<GetTableProvider>().gettablebyid(context, idtable),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Consumer<GetTableProvider>(
                  builder: ((context, model, _) {
                    return GridView.count(
                      crossAxisCount: 2,
                      physics: ScrollPhysics(),
                      childAspectRatio: (0.8.w / .5.h),
                      shrinkWrap: true,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 10.0,
                      children: List.generate(snapshot.data!.length, (index) {
                       
                        return GestureDetector(
                          onTap: (() {
                            bool clicktable = true;
                            context.read<ClickTableProvider>().clickTableProvider(clicktable);
                            CountPre()
                                .setTableName(snapshot.data![index].name!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) =>
                                    TableDetail(data: snapshot.data![index])),
                              ),
                            );
                            setState(() {
                              selectTable = index;
                              context.read<ListTableProvider>().addTable(snapshot.data![index].name!);
                            });
                          }),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 10.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppTheme.BASE_COLOR,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 10.w,
                                      decoration: BoxDecoration(
                                        color: checkStatus(snapshot.data![index].status!),
                                        border: Border.all(
                                            color: AppTheme.BASE_COLOR),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Container(
                                        height: 70.h,
                                        width: 130.w,
                                        decoration: BoxDecoration(
                                            color: selectTable == index
                                                ? AppTheme.BASE_COLOR
                                                : AppTheme.GREY_COLOR,
                                            border: Border.all(
                                                color: AppTheme.BASE_COLOR),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            selectTable == index
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color: AppTheme.WHITE_COLOR,
                                                  )
                                                : SizedBox(),
                                            Center(
                                              child: Text(
                                                snapshot.data![index].name!,
                                                style: TextStyle(
                                                  color: selectTable == index
                                                      ? AppTheme.WHITE_COLOR
                                                      : AppTheme.BASE_COLOR,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Container(
                                      height: 50.h,
                                      width: 10.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppTheme.BASE_COLOR),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  height: 10.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppTheme.BASE_COLOR),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
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
        )
      ],
    );
  }
}
