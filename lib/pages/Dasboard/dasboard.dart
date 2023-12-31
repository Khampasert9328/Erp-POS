import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/Bill/bill.dart';
import 'package:erp_pos/pages/Dasboard/dasboard1.dart';
import 'package:erp_pos/pages/Order/order.dart';
import 'package:erp_pos/pages/food_menu/food_menu.dart';
import 'package:flutter/material.dart';
import '../Table/table.dart';

class Dasboard extends StatefulWidget {
  GetTable data;
   Dasboard({Key? key, required this.data}) : super(key: key);
  @override
  State<Dasboard> createState() => _DasboardState();
}

class _DasboardState extends State<Dasboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(ERPImages.ellipse),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "ສະບາຍດີ!",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "ວິລະພົງ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    ERPImages.setting,
                  ),
                ),
              )
            ],
            bottom: const TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              indicatorWeight: 5,
              labelStyle: TextStyle(
                fontSize: 18,
                fontFamily: 'NotoSansLao-Regular',
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(
                  text: "ວັນ",
                ),
                Tab(
                  text: "ອາທິດ",
                ),
                Tab(
                  text: "ເດືອນ",
                ),
                Tab(
                  text: "ປີ",
                ),
                Tab(
                  text: "ທັງໝົດ",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Dasboard1(),
            POSTable(),
            FoodMenu(),
          
            Bill(),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: TabBar(
            labelColor: Colors.black,
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 3,
                ),
                insets: EdgeInsets.only(top: 44)),
            indicatorWeight: 5,
            isScrollable: true,
            labelStyle: const TextStyle(
              fontSize: 18,
              fontFamily: 'NotoSansLao-Regular',
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: 'ພາບລວມ',
                icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    ERPImages.dashboard,
                  ),
                ),
              ),
              Tab(
                text: 'ໂຕະ',
                icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    ERPImages.table,
                  ),
                ),
              ),
              Tab(
                text: 'ເມນູອາຫານ',
                icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    ERPImages.menu,
                  ),
                ),
              ),
              Tab(
                text: 'ອໍເດີ',
                icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    ERPImages.order,
                  ),
                ),
              ),
              Tab(
                text: 'ໃບບິນ',
                icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    ERPImages.bill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
