import 'package:erp_pos/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/sign_in.dart';
import 'components/sign_up.dart';

class Login extends StatelessWidget {
  bool isSignUpscreen = true;
  bool openPassword = true;

  final fromkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldkey,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 116.h,
              ),
              Image.asset(
                "images/narharn.png",
                width: 271.w,
              ),
              SizedBox(
                height: 50.h,
              ),
              TabBar(
                indicatorPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                indicatorWeight: 3.0,
                indicatorColor: AppTheme.BASE_COLOR,
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 18.sp,
                ),
                tabs: [
                  Tab(
                    text: 'ເຂົ້າສູ່ລະບົບ',
                  ),
                  Tab(
                    text: 'ລົງທະບຽນ',
                  ),
                ],
              ),
              Expanded(
                  child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SignIn(),
                  SignUp(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
