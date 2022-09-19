import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/widget/app_button.dart';
import 'package:erp_pos/widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUp extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Form(
        key: formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  'ອີເມວ',
                  style: TextStyle(color: AppTheme.BASE_COLOR, fontSize: 14.sp),
                ),
                AppTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  hintText: 'ອີເມວ',
                  validator:
                      EmailValidator(errorText: 'ກະລຸນາປ້ອນອີເມວໃຫ້ຖືກຕ້ອງ'),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Text(
                  'ຊື່ຮ້ານ/ບໍລິສັດ',
                  style: TextStyle(color: AppTheme.BASE_COLOR, fontSize: 14.sp),
                ),
                AppTextField(
                    controller: company,
                    hintText: 'ຊື່ຮ້ານ/ບໍລິສັດ',
                    validator: RequiredValidator(
                        errorText: 'ກະລຸນາປ້ອນຊື່ຮ້ານ/ບໍລິສັດ')),
                SizedBox(
                  height: 14.h,
                ),
                Text(
                  'ຊື່',
                  style: TextStyle(color: AppTheme.BASE_COLOR, fontSize: 14.sp),
                ),
                AppTextField(
                    controller: firstName,
                    hintText: 'ຊື່',
                    validator: RequiredValidator(errorText: 'ກະລຸນາປ້ອນຊື່')),
                SizedBox(
                  height: 14.h,
                ),
                Text(
                  'ນາມສະກຸນ',
                  style: TextStyle(color: AppTheme.BASE_COLOR, fontSize: 14.sp),
                ),
                AppTextField(
                  controller: lastName,
                  hintText: 'ນາມສະກຸນ',
                  validator: EmailValidator(errorText: 'ກະລຸນາປ້ອນນາມສະກຸນ'),
                ),
                SizedBox(
                  height: 47.h,
                ),
                AppButton(text: 'ລົງທະບຽນ', onPressed: () {}),
                SizedBox(
                  height: 46.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
