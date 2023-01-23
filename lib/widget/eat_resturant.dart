import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/table/components/navbar_status_booking_next.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/listtable/list_table_provider.dart';
import 'package:erp_pos/provider/tableprovider/click_table_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/utils/check_status.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EatResturant extends StatefulWidget {
  const EatResturant({super.key});

  @override
  State<EatResturant> createState() => _EatResturantState();
}

class _EatResturantState extends State<EatResturant> {
  bool selectindex = true;
  bool selecbutton = false;
  int? selectTable = 0;
  int? selectIndex = 0;

  int? isselect = 0;
  String? idtable;
  String? sc;
  bool selectMenu = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AreaProvider>(
      builder: ((context, value, child) {
        if (value.areaModels == null) {
          return const Text("ບໍ່ມີຂໍ້ມູນ");
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
                        String idArea = value.areaModels!.area![index].id ?? '';
                        String beforeID = value.idarea;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          context
                                              .read<AreaProvider>()
                                              .setAreaID(idArea);
                                          setState(() {
                                            selectIndex = index;

                                            context
                                                .read<AreaProvider>()
                                                .callAPITable(
                                                  context,
                                                  idArea,
                                                );
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8,
                                              ),
                                              child: AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                height: 40.h,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: idArea == beforeID
                                                      ? AppTheme.BASE_COLOR
                                                      : AppTheme.WHITE_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color:
                                                          AppTheme.BASE_COLOR),
                                                ),
                                                child: Center(
                                                  child: Mystyle().syleText(
                                                      value.areaModels!
                                                          .area![index].area!,
                                                      idArea == beforeID
                                                          ? AppTheme.WHITE_COLOR
                                                          : Colors.grey,
                                                      18.sp),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Visibility(
                                        visible: selectIndex == index,
                                        child: Container(
                                          height: 5.h,
                                          width: 5.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppTheme.BASE_COLOR,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      })),
              SizedBox(
                height: 5.h,
              ),
              NavBarStatusBooking(),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: value.isloading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: AppTheme.BASE_COLOR,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            const Text(
                              "ກຳລັງໂຫຼດຂໍ້ມູນ...",
                              style: TextStyle(
                                fontFamily: 'Phetsarath-OT',
                              ),
                            )
                          ],
                        ),
                      )
                    : value.gettablelist == null
                        ? const Center(
                            child: Text("ບໍ່ມີຂໍ້ມູນໂຕະ"),
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
                                      value.gettablelist!.table!.length,
                                      (index) {
                                    return GestureDetector(
                                      onTap: (() async {
                                        setState(() {
                                          selectIndex = index;
                                        });
                                        if (value.gettablelist!.table![index]
                                                .statusAv ==
                                            1) {
                                          Mystyle().dialogError(context, "ແຈ້ງເຕືອນ", "ໂຕະກຳລັງດຳເນີນການຢູ່");
                                        } else {
                                          setState(() {
                                            selectTable = index;
                                          });
                                          CountPre().setTableId(value
                                              .gettablelist!.table![index].id!);
                                          CountPre().setTableName(value
                                              .gettablelist!
                                              .table![index]
                                              .name!);
                                          CountPre().setArea(value.gettablelist!
                                              .table![index].tablearea!.area!);

                                          context
                                              .read<ClickTableProvider>()
                                              .clickTableProvider(true);
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
                                                      value
                                                          .gettablelist!
                                                          .table![index]
                                                          .statusAv!,
                                                    ),
                                                    border: Border.all(
                                                        color: AppTheme
                                                            .BASE_COLOR),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Container(
                                                    height: 70.h,
                                                    width: 130.w,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            selectTable == index
                                                                ? AppTheme
                                                                    .BASE_COLOR
                                                                : AppTheme
                                                                    .GREY_COLOR,
                                                        border: Border.all(
                                                            color: AppTheme
                                                                .BASE_COLOR),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
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
                                                                  FontWeight
                                                                      .bold,
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
                                                      10,
                                                    ),
                                                  ),
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
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
              )
            ],
          );
        }
      }),
    );
  }
}
