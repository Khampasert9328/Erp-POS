// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last

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
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/services/getArea/get_area.dart';
import 'package:erp_pos/utils/check_status.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:erp_pos/constant/routes.dart' as custom_route;

import '../../../constant/theme.dart';

class ListViewTable extends StatefulWidget {
  const ListViewTable({
    Key? key,
  }) : super(key: key);

  @override
  State<ListViewTable> createState() => _ListViewTableState();
}

int? selectIndex = 0;
String? idtable;
int selectTable = 0;

class _ListViewTableState extends State<ListViewTable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: FutureBuilder<List<Area>>(
                    future: AreaProvider().getZone(),
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
                                  String? id = snapshot.data![index].id ?? "";

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectIndex = index;
                                                  idtable = id;
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 8,
                                                    ),
                                                    child: Container(
                                                      height: 40.h,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 15.w,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: selectIndex ==
                                                                  index
                                                              ? AppTheme
                                                                  .BASE_COLOR
                                                              : AppTheme
                                                                  .WHITE_COLOR,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: AppTheme
                                                                  .BASE_COLOR)),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .area!,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18.sp,
                                                            color: selectIndex == index
                                                                ? AppTheme
                                                                    .WHITE_COLOR
                                                                : AppTheme
                                                                    .GREY_COLOR,
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
              ),
            ],
          ),
          const NavBarStatusBooking(),
          FutureBuilder<List<GetTable>>(
            future: GetTableProvider().gettablebyid(context, idtable),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Consumer<GetTableProvider>(
                  builder: ((context, model, _) {
                    return SingleChildScrollView(
                        child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (0.8 / .4),
                      shrinkWrap: true,
                      children: List.generate(snapshot.data!.length, (index) {
                        return GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      TableDetail(data: snapshot.data![index])),
                                ),
                              );
                              setState(() {
                                selectTable = index;
                              });
                            }),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: selectTable == index
                                        ? AppTheme.BASE_COLOR
                                        : AppTheme.GREY_COLOR,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: AppTheme.GREEN_COLOR,
                                          width: 15,
                                        ),
                                      ),
                                    ),
                                    child: Stack(
                                      alignment: AlignmentDirectional.topEnd,
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
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: selectTable == index
                                                    ? AppTheme.WHITE_COLOR
                                                    : AppTheme.BASE_COLOR),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ));
                      }),
                    ));
                  }),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: AppTheme.BASE_COLOR,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
