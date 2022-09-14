import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:erp_pos/bussiness%20logic/authentication.dart';
import 'package:erp_pos/constant/theme.dart';
import 'package:erp_pos/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatelessWidget {
  bool isSignUpscreen = true;
  bool openPassword = true;

  final fromkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  //controller for login
  TextEditingController erpemail = TextEditingController();
  TextEditingController erpusername = TextEditingController();
  TextEditingController erppassword = TextEditingController();
//controller for register
  TextEditingController erpsemail = TextEditingController();
  TextEditingController erpsname = TextEditingController();
  TextEditingController erpslastname = TextEditingController();
  TextEditingController erpsnamecompany = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldkey,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 100,
                    right: 15,
                    left: 15,
                  ),
                  child: Image.asset("images/narharn.png"),
                ),
                const SizedBox(
                  height: 70,
                ),
                TabBar(
                  tabs: [
                    Tab(text: 'ເຂົ້າສູ່ລະບົບ',),
                    Tab(text: 'ລົງທະບຽນ',),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     GestureDetector(
                //       onTap: (() {
                //         setState(() {
                //           isSignUpscreen = true;
                //         });
                //       }),
                //       child: Column(
                //         children: [
                //           Text(
                //             "ເຂົ້າສູ່ລະບົບ",
                //             style: TextStyle(
                //               color: isSignUpscreen
                //                   ? Colors.blue
                //                   : Colors.grey[500],
                //               fontSize: 20,
                //               fontFamily: "NotoSansLao-Regular",
                //             ),
                //           ),
                //
                //           Container(
                //             width: 150.w,
                //             height: 3.h,
                //             color:!isSignUpscreen? Colors.grey:Colors.blue,
                //           ),
                //         ],
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           isSignUpscreen = false;
                //         });
                //       },
                //       child: Column(
                //         children: [
                //           Text(
                //             "ລົງທະບຽນ",
                //             style: TextStyle(
                //               color: !isSignUpscreen
                //                   ? Colors.blue
                //                   : Colors.grey[500],
                //               fontSize: 20,
                //               fontFamily: "NotoSansLao-Regular",
                //             ),
                //           ),
                //
                //           Container(
                //             width: 150.w,
                //             height: 3.h,
                //             color:!isSignUpscreen? Colors.blue:Colors.grey,
                //           ),
                //         ],
                //       ),
                //     )
                //   ],
                // ),
                if (isSignUpscreen) sigIn(),
                if (!isSignUpscreen) signUp()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sigIn() {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Form(
        key: fromkey,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            email(),
            const SizedBox(
              height: 15,
            ),
            password(),
            const SizedBox(
              height: 15,
            ),
            forgotPassword(),
            const SizedBox(
              height: 15,
            ),
            submitlogin()
          ],
        ),
      ),
    );
  }

  Widget email() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        child: TextFormField(
          controller: erpemail,
          keyboardType: TextInputType.emailAddress,
          validator: ((value) {
            if (value!.isEmpty ||
                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
              return "ກາລຸນາໃສ່ອີເມລໃຫ້ຖືກຕ້ອງ";
            } else {
              return null;
            }
          }),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xffedebeb),
            border: InputBorder.none,
            hintText: 'ອີເມລ',
            prefixIcon: Icon(Icons.email),
            hintStyle: TextStyle(
              fontFamily: "NotoSansLao-Regular",
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget password() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        child: TextFormField(
          controller: erppassword,
          keyboardType: TextInputType.text,
          validator: ((value) {
            if (value!.trim().isEmpty) {
              return "ກາລຸນາໃສ່ລະຫັດຜ່ານ";
            } else {
              return null;
            }
          }),
          obscureText: openPassword,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffedebeb),
              border: InputBorder.none,
              hintText: 'ລະຫັດຜ່ານ',
              prefixIcon: const Icon(Icons.lock),
              hintStyle: const TextStyle(
                fontFamily: "NotoSansLao-Regular",
                fontSize: 18,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    openPassword = !openPassword;
                  });
                },
                icon: openPassword
                    ? const Icon(
                  Icons.visibility_off,
                  color: Colors.blue,
                )
                    : const Icon(
                  Icons.remove_red_eye,
                  color: Colors.blue,
                ),
              )),
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {},
            child: const Text(
              "ລືມລະຫັດຜ່ານ",
              style: TextStyle(
                  fontFamily: 'NotoSansLao-Regular',
                  fontSize: 18,
                  color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }

  Widget submitlogin() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () async {
          if (fromkey.currentState!.validate()) {
            AuthenticationProvider().login(erpemail.text, erpusername.text,
                erppassword.text, context, "", "");
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.indigo[900],
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(
            child: Text(
              'ເຂົ້າສູ່ລະບົບ',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NotoSansLao-Regular',
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Widget signUp() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        key: fromkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            nameemail(),
            signInemail(),
            nameCompany(),
            signICompany(),
            name(),
            singInName(),
            surname(),
            singInSurname(),
            builsubmit(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget nameemail() {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        "ອີເມລ",
        style: TextStyle(
          fontSize: 20,
          fontFamily: "NotoSansLao-Regular",
        ),
      ),
    );
  }

  Widget signInemail() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: erpsemail,
        validator: ((value) {
          if (value!.isEmpty ||
              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
            return "ກາລຸນາໃສ່ອີເມລໃຫ້ຖືກຕ້ອງ";
          } else {
            return null;
          }
        }),
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.blue,
        decoration: const InputDecoration(
            hintStyle: TextStyle(
              fontFamily: "NotoSansLao-Regular",
            ),
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget nameCompany() {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        "ຊື່ຮ້ານ/ບໍລິສັດ",
        style: TextStyle(
          fontSize: 20,
          fontFamily: "NotoSansLao-Regular",
        ),
      ),
    );
  }

  Widget signICompany() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: erpsnamecompany,
        validator: ((value) {
          if (value!.isEmpty) {
            return "ກາລຸນາໃສ່ຊື່ຮ້ານ/ບໍລິສັດໃຫ້ຖືກຕ້ອງ";
          } else {
            return null;
          }
        }),
        keyboardType: TextInputType.text,
        cursorColor: Colors.blue,
        decoration: const InputDecoration(
            hintStyle: TextStyle(
              fontFamily: "NotoSansLao-Regular",
            ),
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget name() {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        "ຊື່",
        style: TextStyle(
          fontSize: 20,
          fontFamily: "NotoSansLao-Regular",
        ),
      ),
    );
  }

  Widget singInName() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: erpsname,
        validator: ((value) {
          if (value!.isEmpty) {
            return "ກາລຸນາໃສ່ຊື່ໃຫ້ຖືກຕ້ອງ";
          } else {
            return null;
          }
        }),
        keyboardType: TextInputType.text,
        cursorColor: Colors.blue,
        decoration: const InputDecoration(
            hintStyle: TextStyle(
              fontFamily: "NotoSansLao-Regular",
            ),
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget surname() {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        "ນາມສະກຸນ",
        style: TextStyle(
          fontSize: 20,
          fontFamily: "NotoSansLao-Regular",
        ),
      ),
    );
  }

  Widget singInSurname() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: erpslastname,
        validator: ((value) {
          if (value!.isEmpty) {
            return "ກາລຸນາໃສ່ນາມສະກຸນໃຫ້ຖືກຕ້ອງ";
          } else {
            return null;
          }
        }),
        keyboardType: TextInputType.text,
        cursorColor: Colors.blue,
        decoration: const InputDecoration(
            hintStyle: TextStyle(
              fontFamily: "NotoSansLao-Regular",
            ),
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget builsubmit() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () async {
          try {
            if (fromkey.currentState!.validate()) {
              AuthenticationProvider().validateUser(
                  erpsemail.text, erpsname.text, context, erpslastname.text);
            }
          } catch (e) {}
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.indigo[900],
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(
            child: Text(
              'ລົງທະບຽນ',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NotoSansLao-Regular',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

