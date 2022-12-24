// ignore_for_file: unrelated_type_equality_checks

import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/pages/login/login.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/app_button.dart';
import 'package:erp_pos/widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool rememberpassword = false;

  @override
  void initState() {
    CountPre().getemail().then((firstemail) async {
      if (firstemail != null) {
        email.text = firstemail.toString();
      }
    });
    CountPre().getPassword().then((firstPassword) async {
      if (firstPassword != null) {
        password.text = firstPassword.toString();
      }
    });
    CountPre().getRadioRememberPassword().then((value) {
      if (value != null) {
        rememberpassword = value;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: AutofillGroup(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 41.h,
                  ),
                  AppTextField(
                      controller: email,
                      hintText: 'ອີເມວ',
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppTheme.BASE_COLOR,
                        size: (25.w + 25.h) / 2,
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'ກະລຸນາປ້ອນອີເມລກ່ອນ'),
                        // MinLengthValidator(8,
                        //     errorText: 'ກະລຸນາປ້ອນລະຫັດຜ່ານໃຫ້ຄົບ 8 ຕົວ'),
                      ])),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppTextField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: password,
                      hintText: 'ລະຫັດຜ່ານ',
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: AppTheme.BASE_COLOR,
                        size: (25.w + 25.h) / 2,
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'ກະລຸນາປ້ອນລະຫັດຜ່ານກ່ອນ'),
                        // MinLengthValidator(8,
                        //     errorText: 'ກະລຸນາປ້ອນລະຫັດຜ່ານໃຫ້ຄົບ 8 ຕົວ'),
                      ])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Checkbox(
                        value: rememberpassword,
                        onChanged: (value) {
                          setState(() {
                            CountPre().getRadioRememberPassword().then((value) {
                              if (value != null) {
                                rememberpassword = value;
                              }
                            });
                          });
                        },
                      ),
                      Text(
                        "ຈື່ລະຫັດຜ່ານ",
                        style: TextStyle(
                          fontFamily: 'Phetsarath-OT',
                          fontSize: 16.sp,
                        ),
                      )
                    ],
                  ),
                  AppButton(
                      text: 'ເຂົ້າສູ່ລະບົບ',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          AuthenticationProvider().login(
                              email.text,
                              password.text,
                              password.text,
                              context,
                              "",
                              "",
                              rememberpassword);
                          CountPre().setEmail(email.text);
                          CountPre().setPassword(password.text);
                          CountPre().setRadioRememberPassword(rememberpassword);
                        }
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
