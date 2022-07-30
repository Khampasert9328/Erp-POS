import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/homepage/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: HomePageData.pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: HomePageData.homePageBottomBar
            .map((e) => BottomNavigationBarItem(
                  icon: Image.asset(e.icon, width: 30.w, height: 30.h,),
                  label: e.title,
                ))
            .toList(),
        currentIndex: _selectedIndex,
        selectedItemColor: ERPTheme.BASE_COLOR,
        onTap: _onItemTapped,
      ),
    );
  }
}
