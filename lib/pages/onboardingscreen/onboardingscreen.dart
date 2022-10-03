import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/pages/onboardingscreen/onboard_body.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardBody(),
    );
  }
}
