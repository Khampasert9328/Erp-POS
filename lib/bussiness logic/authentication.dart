// ignore_for_file: use_build_context_synchronously

import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/connect/connect_authorize_models.dart';
import 'package:erp_pos/model/connect/connect_create_tenant.dart';
import 'package:erp_pos/model/connect/connect_token_models.dart';
import 'package:erp_pos/model/connect/connect_validate_user.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/pages/login/login.dart';
import 'package:erp_pos/pages/onboardingscreen/models/content_models.dart';
import 'package:erp_pos/services/connect/connect_authorize.dart';
import 'package:erp_pos/services/connect/connect_token.dart';
import 'package:erp_pos/services/connect/create_tenant.dart';
import 'package:erp_pos/services/connect/validate_user.dart';
import 'package:erp_pos/services/getArea/get_area.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier {
  //ສຳລັບລັອກອິນ
  String? idTokenlogin;

  Future<void> login(String email, String username, String password,
      BuildContext context, String name, String lastname) async {
    try {
      showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              insetAnimationDuration: Duration(milliseconds: 5),
              insetAnimationCurve: Curves.bounceOut,
              child: Container(
                height: 100.h,
                width: 100.w,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.BASE_COLOR,
                  ),
                ),
              ),
            );
          });
      ConnectValidateModels? connectValidateModels =
          await connectvalidateuser(email, context, name, lastname);
      // ວິທີການເຊັກເງື່ອນໄຂກວດ User
      if (connectValidateModels != null) {
        //ຖ້າວ່າ connectValidateModels ບໍ່ເທົ່າກັບຄ່າວ່າງ ໃຫ້ມັນ Access ຂໍ Token
        ConnectTokenModels? connectTokenModels =
            await connectToken(email, password, context);
        if (connectTokenModels != null) {
          //Mystyle().showAlertloadingsuccess(context, "ແຈ້ງເຕືອນ", "ກຳລັງເຂົ້າສູ່ລະບົບ");
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString(
              "content", connectTokenModels.content!.accessToken!);
          await Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
        }
      }
    } catch (e) {
      Navigator.pop(context);
      Mystyle()
          .dialogError(context, "ເເຈ້ງເຕືອນ", "ກາລຸນາກວດສອບອິນເຕີເນັດຂອງທ່ານ");
    }
  }

//ສຳລັບລົງທະບຽນ ຫຼື ສະໝັກສະມາຊິກໃໝ່
  Future<void> validateUser(
    String email,
    String name,
    BuildContext context,
    String lastname,
  ) async {
    ConnectValidateModels? connectValidateModel =
        await connectvalidateuser(email, context, name, lastname);
    if (connectValidateModel != null) {}
  }

  Future<void> registerUser(
      BuildContext context, String email, String name, String lastname) async {
    ConnectAuthorizeModels? connectAuthorizeModel =
        await connectAuthorizeModels(email, context);
    if (connectAuthorizeModel != null) {
      String? id = connectAuthorizeModel.id;
      String? accessToken = connectAuthorizeModel.token;
      ConnectCreateTenantModels? createTenantModels =
          await connectCreateTenantModel(
        name,
        lastname,
        id,
        accessToken,
      );
      if (createTenantModels != null) {}
    }
  }
}
