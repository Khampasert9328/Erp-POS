
import 'dart:io';

import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/generateqrmmoney/generateqrmmoney.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/Dasboard/dasboard.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/pages/onboardingscreen/onboardingscreen.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/provider/areaprovider/insert_area_provider.dart';
import 'package:erp_pos/provider/category/category_provider.dart';

import 'package:erp_pos/provider/checkexpiredpackage/check_exp_package_provider.dart';
import 'package:erp_pos/provider/confirmpaymentbybcel/confirmpaymentbybcel_provider.dart';
import 'package:erp_pos/provider/createorder/create_order_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/foodmenu_provider.dart';
import 'package:erp_pos/provider/generateQR/generate_qr_bcelone_provider.dart';
import 'package:erp_pos/provider/generateqrmmoney/generate_qr_mmoney_provider.dart';
import 'package:erp_pos/provider/getaccount/getaccount_provider.dart';
import 'package:erp_pos/provider/getorderbyissuedate/get_order_by_issuedate_provider.dart';
import 'package:erp_pos/provider/getordertable/get_ordertable_provider.dart';
import 'package:erp_pos/provider/gettableall/get_table_all_provider.dart';
import 'package:erp_pos/provider/listtable/list_table_provider.dart';
import 'package:erp_pos/provider/offsession/create_off_session_provider.dart';
import 'package:erp_pos/provider/paycash/paymentcash_provider.dart';

import 'package:erp_pos/provider/sessoin/get_session_provider.dart';
import 'package:erp_pos/provider/switch/switch_provider.dart';
import 'package:erp_pos/provider/tableprovider/click_table_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:erp_pos/provider/updatetable/update_table_provider.dart';
import 'package:erp_pos/utils/setdata/setdata_provider.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant/routes.dart' as custom_route;
import 'package:flutter/material.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: ((context) => AuthenticationProvider())),
            ChangeNotifierProvider(create: (context) => AreaProvider()),
            //ChangeNotifierProvider(create: (context) => GetTableProvider()),
            ChangeNotifierProvider(create: (context) => FoodMenuProvider()),
            ChangeNotifierProvider(create: (context) => GetFoodMenuProvider()),
            ChangeNotifierProvider(
                create: ((context) => CheckExpiredPackage())),

            ChangeNotifierProvider(create: (_) => GenerateQRBCELONE()),
            ChangeNotifierProvider(
                create: (_) => GetOrderByIssueDateProvider()),
            ChangeNotifierProvider(create: (_) => SessionProvoder()),
            ChangeNotifierProvider(create: (_)=>CreateOffSessionProvider()),
            ChangeNotifierProvider(create: (_)=>CreateOrderProvider()),
            ChangeNotifierProvider(create: (_)=>SwitchProvider()),
           ChangeNotifierProvider(create: (_)=>GetTableAllProvider()),
            ChangeNotifierProvider(create: (_)=>PaymentCashProvider()),
            ChangeNotifierProvider(create: (_)=>ConfirmPaymentByBCELONE()),
            ChangeNotifierProvider(create: (_)=>GenerateQrMmoneyProvider()),
            ChangeNotifierProvider(create: (_)=>GetAccountProvider()),
            ChangeNotifierProvider(create: ((_) => ListTableProvider())),
            ChangeNotifierProvider(create: (_)=>UpdateTableProvider()),
            ChangeNotifierProvider(create: (_)=>ClickTableProvider()),
            ChangeNotifierProvider(create: (_)=>SetData()),
            ChangeNotifierProvider(create: (_)=>GetOrderTableProvider()),
            ChangeNotifierProvider(create: (_)=>CategoryProvider())
          ],
          child: MaterialApp(
            theme: ThemeData(
                fontFamily: 'Phetsarath',
                appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: AppTheme.BLACK_COLOR))),
            debugShowCheckedModeBanner: false,
            // routes: custom_route.Route.getAll(),
            home: OnboardingScreen(),
          ),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
