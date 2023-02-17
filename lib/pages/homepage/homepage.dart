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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('ກາລຸນາກວດເບິ່ງອິນເຕີເນັດຂອງທ່ານ', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
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
