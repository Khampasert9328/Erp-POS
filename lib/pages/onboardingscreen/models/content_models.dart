import 'package:erp_pos/constant/images.dart';

class ContentModels {
  String image;
  String title;
  String subtitle;

  ContentModels(
      {required this.image, required this.title, required this.subtitle});

}


  List<ContentModels> content = [
    ContentModels(
      image: ERPImages.onboarding,
      title: "ລະບົບຂາຍໜ້າຮ້ານທີ່ໃຊ້ງ່າຍທີສຸດ",
      subtitle: "ບໍລິຫານ, ຈັດການ ຮ້ານຂອງທ່ານຢ່າງສະດວກສະບາຍ",
    ),
    ContentModels(
      image: ERPImages.onboardScreen,
      title: "ລະບົບຈັດການໂຕະຮ້ານອາຫານ",
      subtitle: "ຕິດຕາມ, ຈັດການ, ລະບຸສະຖານະໂຕະໄດ້ຢ່າງມີປະສິດທິພາບ",
    ),
    ContentModels(
      image: ERPImages.onboard,
      title: "ລະບົບຮັບອໍເດີຜ່ານໂທລະສັບ ແລະ ແທັບເລັດ",
      subtitle: "ປ່ຽນຈາກການຮັບອໍເດີແບບເກົ່າ ສູ່ລະບົບຮັບອໍເດີທີ່ທັນສະໄໝກວ່າ",
    ),
  ];
