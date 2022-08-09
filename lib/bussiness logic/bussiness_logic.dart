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
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  //ສຳລັບລັອກອິນ
  Future<void> login(String email, String username, String password,
      BuildContext context) async {
    ConnectValidateModels? connectValidateModels =
        await connectvalidateuser(email);
    // ວິທີການເຊັກເງື່ອນໄຂກວດ User
    if (connectValidateModels != null) {
      //ຖ້າວ່າ connectValidateModels ບໍ່ເທົ່າກັບຄ່າວ່າງ ໃຫ້ມັນ Access ຂໍ Token
      ConnectTokenModels? connectTokenModels =
          await connectToken(username, password, context);
      if (connectTokenModels != null) {
        // ໄປໜ້າ Dashboard
      }
    }
  }

//ສຳລັບລົງທະບຽນ ຫຼື ສະໝັກສະມາຊິກໃໝ່
  Future<void> register(
    String email,
    String name,
    BuildContext context,
    String lastname,
  ) async {
    try {
      ConnectValidateModels? connectValidateModel =
        await connectvalidateuser(email);
    if (connectValidateModel != null) {
      ConnectAuthorizeModels? connectAuthorizeModel =
          await connectAuthorizeModels(email,context);
      if (connectAuthorizeModel != null) {
        ConnectCreateTenantModels? createTenantModels =
            await connectCreateTenantModel(
          name,
          lastname,
        );
        if (createTenantModels != null) {
          print("success");
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
        }
      }
    }
    print(connectValidateModel);
    } catch (e) {
      print(e);
      
    }
    
  }
}
