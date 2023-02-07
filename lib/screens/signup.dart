////////////////////////////////////////////////////////////
/// Company Name - Fossgen Technologies Pvt Ltd
/// Contact Us - https://fossgentechnologies.com/contact-us/
/// Support - support@fossgentechnologies.com
////////////////////////////////////////////////////////////

import 'dart:convert';
import 'package:dsep_bpp/provides/ApiServices.dart';
import 'package:dsep_bpp/utils/colors_widget.dart';
import 'package:dsep_bpp/utils/globals.dart';
import 'package:dsep_bpp/widgets/custom_loader.dart';
import 'package:dsep_bpp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../widgets/responsive_ui.dart';
import '../widgets/textformfield.dart';
import '../widgets/value_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _passWord = TextEditingController();
  bool loader = false;
  late double _width;
  late double _pixelRatio;
  late bool _large;
  late bool _medium;
  late double _top;
  late double _bottom;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = Responsive.isScreenLarge(_width, _pixelRatio);
    _medium = Responsive.isScreenMedium(_width, _pixelRatio);
    _top = MediaQuery.of(context).viewPadding.top;
    _bottom = MediaQuery.of(context).viewPadding.bottom;
    return SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: whiteColor,
          body: _body(),
        ));
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  heightFactor: 2,
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, size: 30),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: _large
                          ? EdgeInsets.only(top: _top * 5.5)
                          : _medium
                              ? (EdgeInsets.only(top: _top * 1.5))
                              : (EdgeInsets.only(top: _top * 2.5)),
                      child: Image.asset(
                        'assets/images/fossgen_logo.png',
                        width: _width / 2.5,
                        height: _width / 4,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                    text: "Sign up",
                    size: 25,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                textfieldDesign(
                    "User Id", _userIdController, Icons.person, context),
                const SizedBox(
                  height: 10,
                ),
                textfieldDesign("Full Name", _name, Icons.person, context),
                const SizedBox(
                  height: 10,
                ),
                textfieldDesign("Password", _passWord, Icons.person, context),
                const SizedBox(
                  height: 20,
                ),
                button() // Api called after checking validtion
              ],
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: _bottom),
              child: const Text(
                'Powerd by Fossgen',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return SizedBox(
      height: _large ? 50 : (_medium ? 50 : 40),
      width: _width / 1.8,
      child: loader
          ? Loader()
          : PlatformElevatedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_userIdController.text.isNotEmpty &&
                    _name.text.isNotEmpty &&
                    _passWord.text.isNotEmpty) {
                  if (!loader) {
                    setState(() {
                      loader = true;
                    });
                  }
                  Global.username = _name.text;
                  var req = {
                    "userId": _userIdController.text,
                    "password": _passWord.text,
                    "location": "Mumbai",
                    "fullName": _name.text,
                    "providerId": "5f554478-0c1e-4f8f-83ab-f5a95394a3ee"
                  };
                  ApiServices().signUpUser(req).then((value) {
                    if (value == true) {
                      setState(() {
                        loader = false;
                      });
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        loader = false;
                      });
                      Fluttertoast.showToast(
                          msg: value["message"],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  });
                } else {
                  Fluttertoast.showToast(
                      msg: "Please enter the required fields",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              padding: const EdgeInsets.all(8),
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: _large ? 25 : (_medium ? 20 : 15)),
              ),
            ),
    );
  }

  textfieldDesign(
      String hintText, controller, IconData icon, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.7),
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                ValueText(hintText, 0),
                const TextWidget(
                  color: Colors.red,
                  text: " *",
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          CustomTextField(
            obscureText: hintText.contains("Password") ? true : false,
            keyboardType: TextInputType.name,
            textEditingController: controller,
          ),
        ],
      ),
    );
  }
}
