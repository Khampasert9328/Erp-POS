import 'dart:ui';

import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/table/components/navbar_status_booking_next.dart';
import 'package:erp_pos/pages/table_detail/components/table_detail_body.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PlaceToEatCard extends StatefulWidget {
  ScrollController scrollController;

  PlaceToEatCard({required this.scrollController});

  @override
  State<PlaceToEatCard> createState() => _PlaceToEatCardState();
}

class _PlaceToEatCardState extends State<PlaceToEatCard> {
  bool selectindex = true;
  bool selecbutton = true;
  int? selectTable;

  int? isselect;
  String? idtable;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selecbutton = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: selecbutton == true
                              ? ERPTheme.BASE_COLOR
                              : ERPTheme.WHITE_COLOR,
                          border: Border.all(color: ERPTheme.BASE_COLOR),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Text(
                            "ກິນຢູ່ຮ້ານ",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: selecbutton == true
                                    ? ERPTheme.WHITE_COLOR
                                    : ERPTheme.BASE_COLOR),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selecbutton = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: selecbutton == false
                              ? ERPTheme.BASE_COLOR
                              : ERPTheme.WHITE_COLOR,
                          border: Border.all(color: ERPTheme.BASE_COLOR),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Text(
                            "ສັ່ງກັບບ້ານ",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: selecbutton == false
                                    ? ERPTheme.WHITE_COLOR
                                    : ERPTheme.BASE_COLOR),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectindex = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: selectindex == true
                              ? ERPTheme.BASE_COLOR
                              : ERPTheme.WHITE_COLOR,
                          border: Border.all(color: ERPTheme.BASE_COLOR),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Text(
                            "ກິນຢູ່ຮ້ານ",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: selectindex == true
                                    ? ERPTheme.WHITE_COLOR
                                    : ERPTheme.BASE_COLOR),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectindex = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: selectindex == false
                              ? ERPTheme.BASE_COLOR
                              : ERPTheme.WHITE_COLOR,
                          border: Border.all(color: ERPTheme.BASE_COLOR),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Text(
                            "ສັ່ງກັບບ້ານ",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: selectindex == false
                                    ? ERPTheme.WHITE_COLOR
                                    : ERPTheme.BASE_COLOR),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Text(
                  "ເລືອກໂຕະ",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: ERPTheme.BASE_COLOR,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ERPTheme.GREY_COLOR,
                      border: Border.all(color: ERPTheme.WHITE_COLOR),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'ຄົ້ນຫາໂຕະ',
                            hintStyle: TextStyle(
                              fontSize: 15.sp,
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Icon(
                  Icons.search,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
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
                                                  isselect = index;
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
                                                          color: isselect ==
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
                                                            color: isselect ==
                                                                    index
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
            SizedBox(
              height: 10.h,
            ),
            NavBarStatusBooking(),
            SizedBox(
              height: 10.h,
            ),
            Container(
              // height: 300.h,
              child: FutureBuilder<List<GetTable>>(
                future: GetTableProvider().gettablebyid(context, idtable),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Consumer<GetTableProvider>(
                      builder: ((context, model, _) {
                        return SingleChildScrollView(
                          child: GridView.builder(
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
                                  setState(() {
                                    selectTable = index;
                                  });
                                },
                                child: Container(
                                  // height: 300.h,
                                  // width: 30.w,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 35),
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
                                                // ignore: sort_child_properties_last
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
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
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                clipper: ShapeBorderClipper(
                                                  shape: RoundedRectangleBorder(
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
                                          padding:
                                              const EdgeInsets.only(right: 35),
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
                          ),
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
            
          ],
        ),
      ),
    );
  }
}
