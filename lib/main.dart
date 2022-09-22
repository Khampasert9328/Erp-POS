import 'dart:io';
import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/table/table_models.dart';
import 'package:erp_pos/pages/Dasboard/dasboard.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/pages/onboardingscreen/onboardingscreen.dart';
import 'package:erp_pos/provider/areaprovider/area_provider.dart';
import 'package:erp_pos/provider/areaprovider/insert_area_provider.dart';
import 'package:erp_pos/provider/bill/print_bill_customers_provider.dart';
import 'package:erp_pos/provider/bill/print_bill_provider.dart';
import 'package:erp_pos/provider/checkexpiredpackage/check_exp_package_provider.dart';
import 'package:erp_pos/provider/foodmenu/get_foodmenu_provider.dart';
import 'package:erp_pos/provider/foodmenu/sqlite_food_menu.dart';
import 'package:erp_pos/provider/generateQR/generate_qr_bcelone_provider.dart';
import 'package:erp_pos/provider/tableprovider/table_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
            ChangeNotifierProvider(create: (context) => GetTableProvider()),
            ChangeNotifierProvider(create: (context) => FoodMenuProvider()),
            ChangeNotifierProvider(create: (context) => GetFoodMenuProvider()),
            ChangeNotifierProvider(
                create: ((context) => CheckExpiredPackage())),
            ChangeNotifierProvider(
                create: (context) => PrintBillKitchenProvider()),
                ChangeNotifierProvider(create: (_)=>PrintBillCustomers()),
                ChangeNotifierProvider(create: (_)=>GenerateQRBCELONE())
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
