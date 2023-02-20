import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/homepage/data.dart';
import 'package:erp_pos/pages/login/login.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/tableprovider/click_table_provider.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription? subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    getConnection();
    AuthenticationProvider().tokenManagement(context).then((value) async {
      if (value == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => Login())),
        );
      }
    });
    super.initState();
  }

  getConnection() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() {
            isAlertSet = true;
          });
        }
      });

  showDialogBox() => showCupertinoDialog(
        context: context,
        builder: ((context) => CupertinoAlertDialog(
              title: Text(
                "ແຈ້ງເຕືອນ",
                style: TextStyle(
                  fontFamily: 'Phetsarath-OT',
                  fontSize: 18.sp,
                ),
              ),
              content: Text(
                "ກາລຸນາເຊື່ອມຕໍ່ອິນເຕີເນັດ",
                style: TextStyle(
                  fontFamily: 'Phetsarath-OT',
                  fontSize: 15.sp,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context, 'ຍົກເລີກ');
                      setState(() {
                        isAlertSet = false;
                      });
                      isDeviceConnected =
                          await InternetConnectionChecker().hasConnection;
                      if (!isDeviceConnected) {
                        showDialogBox();
                        setState(() {
                          isAlertSet = true;
                        });
                      }
                    },
                    child: Text(
                      "ຕົກລົງ",
                      style: TextStyle(
                        fontFamily: 'Phetsarath-OT',
                        fontSize: 15.sp,
                      ),
                    ))
              ],
            )),
      );
  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: HomePageData.pages[_selectedIndex]),
      bottomNavigationBar: Container(
        color: AppTheme.WHITE_COLOR,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 7.0,
          ),
          child: GNav(
            gap: 8,
            backgroundColor: AppTheme.WHITE_COLOR,
            color: AppTheme.BASE_COLOR,
            activeColor: AppTheme.WHITE_COLOR,
            iconSize: 28,
            textStyle: const TextStyle(
              color: Colors.white,
              fontFamily: 'Phetsarath-OT',
            ),
            tabBackgroundColor: AppTheme.BASE_COLOR,
            padding: EdgeInsets.all(16.0),
            onTabChange: (int index) {
              _onItemTapped(index);
              context.read<GetFoodMenuProvider>().clearKitchenData();
              context.read<ClickTableProvider>().clearbool();
              context.read<ClickTableProvider>().firsOrderMoreTB(false);
              context.read<SetData>().setCheckOrderToBlackhome(false);
              context.read<SetData>().setOrderbill(false);
            },
            tabs: const [
              GButton(
                icon: Icons.table_bar,
                text: 'ໂຕ໋ະ',
              ),
              GButton(
                icon: Icons.local_dining,
                text: 'ເມນູ',
              ),
              GButton(
                icon: Icons.blinds_closed,
                text: 'ໃບບິນ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
