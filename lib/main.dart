import 'package:erp_pos/pages/Dasboard/dasboard.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constant/routes.dart' as custom_route;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _){
        return  MaterialApp(
          theme: ThemeData(fontFamily: 'Phetsarath'),
          debugShowCheckedModeBanner: false,
          routes: custom_route.Route.getAll(),
          home: HomePage(),
        );
      },
    );
  }
}