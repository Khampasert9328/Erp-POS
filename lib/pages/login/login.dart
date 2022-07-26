// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool isSignUpscreen = true;
  bool openPassword = true;
  final fromkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        isSignUpscreen = false;
                      });
                    }),
                    child: Column(
                      children: [
                        Text(
                          "ເຂົ້າສູ່ລະບົບ",
                          style: TextStyle(
                            color: !isSignUpscreen
                                ? Colors.blue
                                : Colors.grey[500],
                            fontSize: 20,
                            fontFamily: "NotoSansLao-Regular",
                          ),
                        ),
                        if (!isSignUpscreen)
                          Container(
                            width: 120,
                            height: 3,
                            color: Colors.blue,
                          ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSignUpscreen = true;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          "ລົງທະບຽນ",
                          style: TextStyle(
                            color: !isSignUpscreen
                                ? Colors.grey[500]
                                : Colors.blue,
                            fontSize: 20,
                            fontFamily: "NotoSansLao-Regular",
                          ),
                        ),
                        if (isSignUpscreen)
                          Container(
                            width: 120,
                            height: 3,
                            color: Colors.blue,
                          ),
                      ],
                    ),
                  )
                ],
              ),
              if (isSignUpscreen) signUp(),
              if (!isSignUpscreen) sigIn()
            ],
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
        onTap: () {
          if (fromkey.currentState!.validate()) {
            final snackbar = const SnackBar(
              backgroundColor: Color(0xff538eed),
              content: Text(
                "ລັອກອິນສຳເລັດ",
                style: TextStyle(
                    fontFamily: 'NotoSansLao-Regular',
                    color: Colors.white,
                    fontSize: 20),
              ),
            );
            // _scaffoldkey.currentState!.showSnackBar(snackbar);
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
        onTap: () {
          if (fromkey.currentState!.validate()) {
            final snackbar = const SnackBar(
              backgroundColor: Color(0xff538eed),
              content: Text(
                "ລົງທະບຽນສຳເລັດແລ້ວ",
                style: TextStyle(
                    fontFamily: 'NotoSansLao-Regular',
                    fontSize: 20,
                    color: Colors.white),
              ),
            );
            _scaffoldkey.currentState!.showSnackBar(snackbar);
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
