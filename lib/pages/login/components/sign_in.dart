import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/widget/app_button.dart';
import 'package:erp_pos/widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignIn extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
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
                validator:
                RequiredValidator(errorText: 'ກະລຸນາປ້ອນອີເມວກ່ອນ'),
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                  obscureText: true,
                  hintText: 'ລະຫັດຜ່ານ',
                  controller: password,
                  prefixIcon: Icon(
                    Icons.key,
                     color: AppTheme.BASE_COLOR,
                    size: (25.w + 25.h) / 2,
                  ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'ກະລຸນາປ້ອນລະຫັດຜ່ານກ່ອນ'),
                    // MinLengthValidator(8,
                    //     errorText: 'ກະລຸນາປ້ອນລະຫັດຜ່ານໃຫ້ຄົບ 8 ຕົວ'),
                  ])),
              SizedBox(
                height: 11.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'ລືມຫັດຜ່ານ',
                    style:
                        TextStyle(color: AppTheme.BASE_COLOR, fontSize: 14.sp),
                  )
                ],
              ),
              SizedBox(
                height: 19.h,
              ),
              AppButton(
                  text: 'ເຂົ້າສູ່ລະບົບ',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AuthenticationProvider().login(email.text, password.text,
                          password.text, context, "", "");
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
