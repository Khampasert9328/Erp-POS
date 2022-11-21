import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/homepage/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
            },
            //style: text(
            //fontFamily: 'NotoSansLao-Regular',
            //),
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
                icon: Icons.local_grocery_store,
                text: "ອໍເດີ",
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
