// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/pages/login/login.dart';
import 'package:erp_pos/pages/onboardingscreen/onboard_body.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
 

  

  @override
  void initState() {
    
    super.initState();
    CountPre().getLogin().then((firstTime) async {
      if (firstTime == true) {
        bool? rember = await CountPre().getRememberPass();
        if (rember == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => HomePage())),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => Login())),
              (route) => false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardBody(),
    );
  }
}
