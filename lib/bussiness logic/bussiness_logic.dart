
import 'package:erp_pos/model/connect_token_models.dart';
import 'package:erp_pos/model/connect_validate_user.dart';
import 'package:erp_pos/services/connect/connect_token.dart';
import 'package:erp_pos/services/connect/validate_user.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationProvider extends ChangeNotifier {
  Future<void> login(String email, String username, String password) async {
    ConnectValidateModels? connectValidateModels =
        await connectvalidateuser(email);
    // ວິທີການເຊັກເງື່ອນໄຂກວດ User
    if (connectValidateModels != null) {
      //ຖ້າວ່າ connectValidateModels ບໍ່ເທົ່າກັບຄ່າວ່າງ ໃຫ້ມັນ Access ຂໍ Token
      ConnectTokenModels? connectTokenModels = await connectToken(username, password);
      if (connectTokenModels != null) {
        // ໄປໜ້າ Dashboard
      }
    }
  }
}
