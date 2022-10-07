import 'package:erp_pos/model/offsession/off_session_models.dart';
import 'package:erp_pos/services/offsession/off_session_service.dart';
import 'package:flutter/material.dart';
class CreateOffSessionProvider extends ChangeNotifier {
  Future<List<OffSesionModels>?> getoffsession(BuildContext context) async {
    OffSesionModels? models = await createoffsession();
    if (models != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ປີດກະສຳເລັດ'),
          action: SnackBarAction(
              label: "ຕົກລົງ",
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      );
    }
  }
}
