// ignore_for_file: use_build_context_synchronously

import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/pages/login/login.dart';
import 'package:erp_pos/pages/onboardingscreen/models/content_models.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardBody extends StatefulWidget {
  const OnboardBody({Key? key}) : super(key: key);

  @override
  State<OnboardBody> createState() => _OnboardBodyState();
}

class _OnboardBodyState extends State<OnboardBody> {
  int currenIndex = 0;
  PageController? pagecontroller;

  @override
  void initState() {
    pagecontroller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pagecontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
              controller: pagecontroller,
              onPageChanged: (int index) {
                setState(() {
                  currenIndex = index;
                });
              },
              itemCount: content.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          content[i].image,
                          height: 300.h,
                        ),
                        Text(
                          content[i].title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Phetsarath-OT',
                          ),
                        ),
                        Text(
                          content[i].subtitle,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Phetsarath-OT',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        builddot(context),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.BLUE_COLOR,
          ),
          height: 60.h,
          width: double.infinity,
          margin: EdgeInsets.all(40),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppTheme.BASE_COLOR,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              if (currenIndex == content.length - 1) {
                bool firstTime = true;
                CountPre().setLogin(firstTime);
                bool? rember = await CountPre().getRememberPass();
                AuthenticationProvider().tokenManagement(context).then((value) {
                  if (value == null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: ((context) => Login())),
                        (route) => false);
                  }
                });
                if (rember == true) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>  HomePage(fromlogin: true,))),
                      (route) => false);
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: ((context) => Login())),
                      (route) => false);
                }
              }

              pagecontroller!.nextPage(
                duration: const Duration(milliseconds: 100),
                curve: Curves.bounceIn,
              );
            },
            child: Text(
              currenIndex == content.length - 1 ? "ເຂົ້າສູ່ລະບົບ" : "ຕໍ່ໄປ",
              style: TextStyle(
                fontFamily: 'Phetsarath-OT',
                fontSize: 20.sp,
              ),
            ),
          ),
        )
      ],
    );
  }

  Container builddot(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          content.length,
          (index) => Container(
            margin: EdgeInsets.only(right: 5.w),
            height: 10.h,
            width: currenIndex == index ? 20.w : 10.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppTheme.BASE_COLOR,
            ),
          ),
        ),
      ),
    );
  }
}
