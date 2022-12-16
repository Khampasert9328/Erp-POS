// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, unused_import
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/api_path.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/detailordertable/detail_order_table.dart';
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
import 'package:erp_pos/provider/updatetable/update_table_provider.dart';
import 'package:erp_pos/services/getArea/get_area.dart';
import 'package:erp_pos/utils/check_status.dart';
import 'package:erp_pos/utils/set_size.dart';
import 'package:erp_pos/utils/setdata/id_table_provider.dart';
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
  void initState() {
    super.initState();
    context.read<AreaProvider>().getZone(context);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AreaProvider>(builder: ((context, value, child) {
      if (value.isloading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (value.areaModels == null) {
          return Text("ບໍ່ມີຂໍ້ມູນ");
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: value.areaModels!.area!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        selectIndex = index;
                                        context
                                            .read<AreaProvider>()
                                            .callAPITable(
                                                context,
                                                value.areaModels!.area![index]
                                                    .id!);
                                        context.read<SetIdTable>().setIdArea(
                                            value.areaModels!.area![index].id!);
                                        context.read<SetIdTable>().setAreaName(
                                            value.areaModels!.area![index]
                                                .area!);

                                                print("idarea:${value.areaModels!.area![index].id!}");
                                                print("area:${ value.areaModels!.area![index]
                                                .area!}");
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
                                                  color: AppTheme.BASE_COLOR),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${value.areaModels!.area![index].area}",
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
                          ],
                        );
                      })),
              NavBarStatusBooking(),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                  child: value.gettablelist == null
                      ? const Center(
                          child: Text("ບໍ່ມີໂຕະ"),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              GridView.count(
                                crossAxisCount: 2,
                                physics: ScrollPhysics(),
                                childAspectRatio: (0.8.w / .5.h),
                                shrinkWrap: true,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 10.0,
                                children: List.generate(
                                    value.gettablelist!.table!.length, (index) {
                                  return GestureDetector(
                                    onTap: (() {
                                      if (value.gettablelist!.table![index]
                                              .status ==
                                          1) {
                                            print("id:${value.gettablelist!
                                                          .table![index].id}");
                                        context.read<SetIdTable>().setIdTable(
                                            value.gettablelist!.table![index]
                                                .id!);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    DetailOrderTable(
                                                      data: value.gettablelist!
                                                          .table![index],
                                                      tablename: value
                                                          .gettablelist!
                                                          .table![index]
                                                          .name!,
                                                    )));
                                      } else {
                                        context.read<SetIdTable>().setIdTable(
                                            value.gettablelist!.table![index]
                                                .id!);
                                        context.read<SetIdTable>().setTableName(
                                            value.gettablelist!.table![index]
                                                .name!);

                                        bool clicktable = true;
                                        context
                                            .read<ClickTableProvider>()
                                            .clickTableProvider(clicktable);
                                        CountPre().setTableName(value
                                            .gettablelist!.table![index].name!);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) => TableDetail(
                                                data: value.gettablelist!
                                                    .table![index])),
                                          ),
                                        );
                                        setState(() {
                                          selectTable = index;
                                          context
                                              .read<ListTableProvider>()
                                              .addTable(value.gettablelist!
                                                  .table![index].name!);
                                        });
                                      }
                                    }),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 10.h,
                                            width: 120.w,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppTheme.BASE_COLOR,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
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
                                                  color: checkStatus(
                                                    value.gettablelist!
                                                        .table![index].status!,
                                                  ),
                                                  border: Border.all(
                                                      color:
                                                          AppTheme.BASE_COLOR),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Container(
                                                  height: 70.h,
                                                  width: 130.w,
                                                  decoration: BoxDecoration(
                                                      color: selectTable ==
                                                              index
                                                          ? AppTheme.BASE_COLOR
                                                          : AppTheme.GREY_COLOR,
                                                      border: Border.all(
                                                          color: AppTheme
                                                              .BASE_COLOR),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.topRight,
                                                    children: [
                                                      selectTable == index
                                                          ? Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color: AppTheme
                                                                  .WHITE_COLOR,
                                                            )
                                                          : SizedBox(),
                                                      Center(
                                                        child: Text(
                                                          value
                                                              .gettablelist!
                                                              .table![index]
                                                              .name!,
                                                          style: TextStyle(
                                                            color: selectTable == index
                                                                ? AppTheme
                                                                    .WHITE_COLOR
                                                                : AppTheme
                                                                    .BASE_COLOR,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                        color: AppTheme
                                                            .BASE_COLOR),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
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
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ))
            ],
          );
        }
      }
    }));
  }
}
