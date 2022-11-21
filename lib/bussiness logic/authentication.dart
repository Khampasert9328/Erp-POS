// ignore_for_file: use_build_context_synchronously, unused_import, unnecessary_import, sized_box_for_whitespace, body_might_complete_normally_nullable, unused_local_variable

import 'dart:convert';

import 'package:erp_pos/constant/data.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/model/area/area_models.dart';
import 'package:erp_pos/model/connect/connect_authorize_models.dart';
import 'package:erp_pos/model/connect/connect_create_tenant.dart';
import 'package:erp_pos/model/connect/connect_token_models.dart';
import 'package:erp_pos/model/connect/connect_validate_user.dart';
import 'package:erp_pos/model/createoffsession/createoffsession_models.dart';
import 'package:erp_pos/model/getsesion/get_sessoin_models.dart';
import 'package:erp_pos/model/refreshtoken/refresh_token_models.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/pages/login/login.dart';
import 'package:erp_pos/pages/onboardingscreen/models/content_models.dart';
import 'package:erp_pos/provider/offsession/create_off_session_provider.dart';
import 'package:erp_pos/provider/switch/switch_provider.dart';
import 'package:erp_pos/services/connect/connect_authorize.dart';
import 'package:erp_pos/services/connect/connect_token.dart';
import 'package:erp_pos/services/connect/create_tenant.dart';
import 'package:erp_pos/services/connect/validate_user.dart';
import 'package:erp_pos/services/getArea/get_area.dart';
import 'package:erp_pos/services/getsession/get_sesion.dart';
import 'package:erp_pos/services/refreshtoken/refresh_token_service.dart';
import 'package:erp_pos/utils/sharepreference/share_pre_count.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier {
  //ສຳລັບລັອກອິນ
  int _isRefreshingToken = 0;
  GetSessoin? _sessoin;

  Future<void> login(
      String email,
      String username,
      String password,
      BuildContext context,
      String name,
      String lastname,
      bool rememberpass) async {
    try {
      showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              insetAnimationDuration: const Duration(milliseconds: 5),
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

      //ວິທີການເຊັກເງື່ອນໄຂກວດ User
      if (connectValidateModels != null) {
        //ຖ້າວ່າ connectValidateModels ບໍ່ເທົ່າກັບຄ່າວ່າງ ໃຫ້ມັນ Access ຂໍ Token
        ConnectTokenModels? connectTokenModels =
            await connectToken(email, password, context);
        if (connectTokenModels != null) {
          //Mystyle().showAlertloadingsuccess(context, "ແຈ້ງເຕືອນ", "ກຳລັງເຂົ້າສູ່ລະບົບ");
          CountPre().setRememberPassword(rememberpass);
          CountPre().setToken(connectTokenModels.content!.accessToken!);
          _sessoin = await getsessionservice();
          if (_sessoin != null) {
            for (var item in _sessoin!.sessionItems!) {
              CountPre().setStatus(item.status!);
              CountPre().setSessionId(item.id!);
            }
          }
          await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false);
        }
      }
    } catch (e) {
      print("Error:$e");
      Mystyle()
          .dialogError(context, "ເເຈ້ງເຕືອນ", "ກາລຸນາກວດສອບອິນເຕີເນັດຂອງທ່ານ");
    }
    notifyListeners();
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

    notifyListeners();
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
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    bool? clearFristTime = await CountPre().getLogin();
    String? saveEmail = await CountPre().getemail();
    String? savePassword = await CountPre().getPassword();
    await pre.clear();
    if ((clearFristTime != null)) {
      if (clearFristTime) {
        await CountPre().setLogin(clearFristTime);
      }

      if (saveEmail != null) {
        await CountPre().setEmail(saveEmail);
      }
      if (savePassword != null) {
        await CountPre().setPassword(savePassword);
      }
    }
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => Login()), (route) => false);

    notifyListeners();
  }

  Future<ConnectTokenModels?> tokenManagement(BuildContext context) async {
    String? connectTokenPref = await CountPre().getconnectToken();

    /// ຖ້າມີ Connect token
    if (connectTokenPref != null) {
      ConnectTokenModels connectTokenData =
          connectTokenModelsFromJson(connectTokenPref);

      /// ກວດ Expired Date ຂອງ Access token
      DateTime expireTokenTime =
          Jwt.getExpiryDate(connectTokenData.content!.accessToken.toString())!
              .toLocal();

      /// ຖ້າ Access token ໝົດອາຍຸ
      if (DateTime.now().isAfter(expireTokenTime)) {
        String clientID = ContstantData.clientID;
        String secret = ContstantData.secret;
        String payload = jsonEncode({
          "clientID": clientID,
          "secret": secret,
          "refreshToken": connectTokenData.content!.refreshToken!
        });

        /// ໃຊ້ເພື່ອໃຫ້ refresh token ໄດ້ແຕ່ເທື່ອດຽວ
        _isRefreshingToken++;
        if (_isRefreshingToken == 1) {
          ConnectTokenModels? connectRefreshTokenData =
              await refreshtoken(connectTokenData.content!.refreshToken!);
          _isRefreshingToken = 0;

          /// ຖ້າ Refresh token ສຳເລັດ
          if (connectRefreshTokenData != null) {
            String data = connectTokenModelsToJson(connectRefreshTokenData);
            await CountPre().setrefreshToken(data);
            return connectRefreshTokenData;
          }
        }
      } else {
        return connectTokenData;
      }
    }

    /// ຖ້າບໍ່ມີ Connect token
    else {
      return null;
      // return showDialog(context: context, builder: (context)=>AlertDialog(title: Text('please input again'),),);
    }
    notifyListeners();
  }
}
