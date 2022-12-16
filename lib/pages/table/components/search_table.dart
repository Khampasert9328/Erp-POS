import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/table/components/navbar_status_booking_next.dart';
import 'package:erp_pos/pages/table_detail/components/table_detail_body.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchTable extends StatefulWidget {
  const SearchTable({Key? key}) : super(key: key);

  @override
  State<SearchTable> createState() => _SearchTableState();
}

class _SearchTableState extends State<SearchTable> {
  int? selectIndex = 0;
  String? idtable;
  int selectTable = 0;
  TextEditingController searchtable = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.WHITE_COLOR,
        title: TextField(
          controller: searchtable,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'ຄົ້ນຫາໂຕະ',
              hintStyle: TextStyle(
                fontFamily: 'Phetsarath-OT',
                fontSize: 15.sp,
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: FutureBuilder<List<Area>>(
                  //future: context.read<AreaProvider>().getZone(),
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

                                if (searchtable.text.isEmpty) {
                                  return Container();
                                } else {
                                  if (snapshot.data![index].id!
                                      .contains(searchtable.text)) {
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
                                                        padding: EdgeInsets
                                                            .symmetric(
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
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                                color: AppTheme
                                                                    .BASE_COLOR)),
                                                        child: Center(
                                                          child: Text(
                                                            snapshot
                                                                .data![index]
                                                                .area!,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Phetsarath-OT',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18.sp,
                                                              color: selectIndex == index
                                                                  ? AppTheme
                                                                      .WHITE_COLOR
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
                                         NavBarStatusBooking(),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    );
                                  }
                                }
                                return Container();
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
              SizedBox(
                height: 10.h,
              ),
              // FutureBuilder<List<GetTable>>(
              //   future: context
              //       .read<GetTableProvider>()
              //       .gettablebyid(context,),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return Consumer<GetTableProvider>(
              //         builder: ((context, model, _) {
              //           return GridView.count(
              //             crossAxisCount: 2,
              //             physics: ScrollPhysics(),
              //             childAspectRatio: (0.8 / .5),
              //             shrinkWrap: true,
              //             crossAxisSpacing: 20.0,
              //             // mainAxisSpacing: .0,
              //             children:
              //                 List.generate(snapshot.data!.length, (index) {
              //               if (searchtable.text.isEmpty) {
              //                 return Container();
              //               } else {
              //                 if (snapshot.data![index].name!
              //                     .contains(searchtable.text)) {
              //                   return GestureDetector(
              //                     onTap: (() {
              //                       bool clicktable = true;
              //                       CountPre().setClickTable(clicktable);
              //                       CountPre().setTableName(
              //                           snapshot.data![index].name!);
              //                       Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                           builder: ((context) => TableDetail(
              //                               data: snapshot.data![index])),
              //                         ),
              //                       );
              //                       setState(() {
              //                         selectTable = index;
              //                       });
              //                     }),
              //                     child: SingleChildScrollView(
              //                       child: Column(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.center,
              //                         children: [
              //                           Container(
              //                             height: 10.h,
              //                             width: 120.w,
              //                             decoration: BoxDecoration(
              //                                 border: Border.all(
              //                                   color: AppTheme.BASE_COLOR,
              //                                 ),
              //                                 borderRadius:
              //                                     BorderRadius.circular(10)),
              //                           ),
              //                           SizedBox(
              //                             height: 5.h,
              //                           ),
              //                           Row(
              //                             children: [
              //                               Container(
              //                                 height: 50.h,
              //                                 width: 10.w,
              //                                 decoration: BoxDecoration(
              //                                     color: AppTheme.GREEN_COLOR,
              //                                     border: Border.all(
              //                                         color:
              //                                             AppTheme.BASE_COLOR),
              //                                     borderRadius:
              //                                         BorderRadius.circular(
              //                                             10)),
              //                               ),
              //                               SizedBox(
              //                                 width: 3.w,
              //                               ),
              //                               Container(
              //                                   height: 70.h,
              //                                   width: 130.w,
              //                                   decoration: BoxDecoration(
              //                                       color: selectTable == index
              //                                           ? AppTheme.BASE_COLOR
              //                                           : AppTheme.GREY_COLOR,
              //                                       border: Border.all(
              //                                           color: AppTheme
              //                                               .BASE_COLOR),
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               10)),
              //                                   child: Stack(
              //                                     alignment: Alignment.topRight,
              //                                     children: [
              //                                       selectTable == index
              //                                           ? Icon(
              //                                               Icons.check_circle,
              //                                               color: AppTheme
              //                                                   .WHITE_COLOR,
              //                                             )
              //                                           : SizedBox(),
              //                                       Center(
              //                                         child: Text(
              //                                           snapshot
              //                                               .data![index].name!,
              //                                           style: TextStyle(
              //                                             color: selectTable ==
              //                                                     index
              //                                                 ? AppTheme
              //                                                     .WHITE_COLOR
              //                                                 : AppTheme
              //                                                     .BASE_COLOR,
              //                                             fontSize: 14.sp,
              //                                             fontWeight:
              //                                                 FontWeight.bold,
              //                                           ),
              //                                         ),
              //                                       ),
              //                                     ],
              //                                   )),
              //                               SizedBox(
              //                                 width: 3.w,
              //                               ),
              //                               Container(
              //                                 height: 50.h,
              //                                 width: 10.w,
              //                                 decoration: BoxDecoration(
              //                                     border: Border.all(
              //                                         color:
              //                                             AppTheme.BASE_COLOR),
              //                                     borderRadius:
              //                                         BorderRadius.circular(
              //                                             10)),
              //                               ),
              //                             ],
              //                           ),
              //                           SizedBox(
              //                             height: 3.h,
              //                           ),
              //                           Container(
              //                             height: 10.h,
              //                             width: 120.w,
              //                             decoration: BoxDecoration(
              //                                 border: Border.all(
              //                                     color: AppTheme.BASE_COLOR),
              //                                 borderRadius:
              //                                     BorderRadius.circular(10)),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   );
              //                 }
              //               }
              //               return Container();
              //             }),
              //           );
              //         }),
              //       );
              //     }
              //     return Center(
              //       child: CircularProgressIndicator(
              //         color: AppTheme.BASE_COLOR,
              //       ),
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
