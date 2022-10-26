import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/table/components/navbar_status_booking_next.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
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

  int? isselect = 0;
  String? idtable;
  String? sc;
  bool selectMenu = false;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                String? id = snapshot.data![index].id ?? "";

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                isselect = index;
                                                idtable = id;
                                              });
                                              SharedPreferences preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              preferences.setString(
                                                  CountPre().idzone,
                                                  snapshot.data![index].area!);
                                              CountPre().setTableId(
                                                  idtable.toString());
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
                                                        color: isselect == index
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
                                                        snapshot
                                                            .data![index].area!,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18.sp,
                                                          color: isselect ==
                                                                  index
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
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        const NavBarStatusBooking(),
        SizedBox(
          height: 10.h,
        ),
        Expanded(
          child: FutureBuilder<List<GetTable>>(
            future: GetTableProvider().gettablebyid(context, idtable),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Consumer<GetTableProvider>(
                  builder: ((context, model, _) {
                    return GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (0.8 / .4),
                      shrinkWrap: true,
                      children: List.generate(snapshot.data!.length, (index) {
                        return GestureDetector(
                          onTap: (() async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.setString(
                                CountPre().tableid, snapshot.data![index].id!);
                            preferences.setString(CountPre().tablename,
                                snapshot.data![index].name!);
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: (() {
                                setState(() {
                                  selectTable = index;
                                });
                              }),
                              child: Container(
                                color: selectTable == index
                                    ? AppTheme.BASE_COLOR
                                    : AppTheme.GREY_COLOR,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: selectTable == index
                                            ? AppTheme.GREEN_COLOR
                                            : AppTheme.GREEN_COLOR,
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
                                  ),
                                ),
                              ),
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
        ),
      ],
    );
  }
}
