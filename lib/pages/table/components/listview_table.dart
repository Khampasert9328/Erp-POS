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

int? selectIndex;
String? idtable;


class _ListViewTableState extends State<ListViewTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 50.h,
                  width: 200.w,
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
                                                              ? ERPTheme
                                                                  .BASE_COLOR
                                                              : ERPTheme
                                                                  .WHITE_COLOR,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: ERPTheme
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
                                                                ? ERPTheme
                                                                    .WHITE_COLOR
                                                                : ERPTheme
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
                      return SizedBox();
                    },
                  ),
                ),
              ],
            ),
            NavBarStatusBooking(),
            SingleChildScrollView(
              child: SizedBox(
                height: 600.h,
                width: 600.w,
                child: Container(
                  height: 300.h,
                  child: FutureBuilder<List<GetTable>>(
                    future: GetTableProvider().gettablebyid(context, idtable),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Consumer<GetTableProvider>(
                          builder: ((context, model, _) {
                            return GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 65,
                                childAspectRatio: 1 / .5,
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TableDetail(data: snapshot.data![index]),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 300.h,
                                    width: 30,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 35),
                                            child: Container(
                                              // height: 14.h,
                                              width: 90.w,
                                              decoration: BoxDecoration(
                                                  color: ERPTheme.CARD_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 60.h,
                                              width: 10.w,
                                              decoration: BoxDecoration(
                                                  color: ERPTheme.CARD_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                            SizedBox(
                                              height: 70.h,
                                              width: 100.w,
                                              child: Card(
                                                color: ERPTheme.CARD_COLOR,
                                                child: ClipPath(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        left: BorderSide(
                                                          color: ERPTheme
                                                              .GREEN_COLOR,
                                                          width: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        snapshot
                                                            .data![index].name!,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  clipper: ShapeBorderClipper(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 60.h,
                                              width: 10.w,
                                              decoration: BoxDecoration(
                                                  color: ERPTheme.CARD_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 35),
                                            child: Container(
                                              // height: 14.h,
                                              width: 95.w,
                                              decoration: BoxDecoration(
                                                  color: ERPTheme.CARD_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: ERPTheme.BASE_COLOR,
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
