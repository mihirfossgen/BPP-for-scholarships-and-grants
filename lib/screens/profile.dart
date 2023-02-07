////////////////////////////////////////////////////////////
/// Company Name - Fossgen Technologies Pvt Ltd
/// Contact Us - https://fossgentechnologies.com/contact-us/
/// Support - support@fossgentechnologies.com
//////////////////////////////////////////////////////////

import 'package:dsep_bpp/screens/signin.dart';
import 'package:dsep_bpp/utils/colors_widget.dart';
import 'package:dsep_bpp/utils/globals.dart';
import 'package:dsep_bpp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    packageInfo();
  }

  String version = "";

  packageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      body: _body(),
    ));
  }

  List<Widget> _listTile() {
    List<Widget> _list = [];
    for (var i = 0; i < 1; i++) {
      _list.add(Container(
        height: 50,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: whiteColor, boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 2, spreadRadius: 2)
        ]),
        child: ListTile(
          title: const Text(
            'Sign Out',
            style: TextStyle(
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF253840),
            ),
            textAlign: TextAlign.left,
          ),
          trailing: const Icon(
            Icons.power_settings_new,
            color: Colors.red,
          ),
          onTap: () {
            onTapped();
          },
        ),
      ));
    }
    return _list;
  }

  Future<void> onTapped() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Align(
            child: Image.asset(
              'assets/images/default_profile.jpeg',
              height: 100,
            ),
            alignment: Alignment.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            child: TextWidget(
              text: Global.username,
              size: 20,
            ),
            alignment: Alignment.center,
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Container(
                height: 50,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: whiteColor, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 2,
                      spreadRadius: 2)
                ]),
                child: ListTile(
                  title: const Text(
                    'Sign Out',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF253840),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  trailing: const Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
                  ),
                  onTap: () {
                    onTapped();
                  },
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 100.0),
                child: const TextWidget(
                  text: "DSEP ",
                  size: 14,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 100.0),
                child: const TextWidget(text: "App Version", size: 14),
              ),
              Container(
                margin: const EdgeInsets.only(top: 100.0),
                child: Text(
                  " $version",
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
