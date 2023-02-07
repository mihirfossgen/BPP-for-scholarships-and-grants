////////////////////////////////////////////////////////////
/// Company Name - Fossgen Technologies Pvt Ltd
/// Contact Us - https://fossgentechnologies.com/contact-us/
/// Support - support@fossgentechnologies.com
//////////////////////////////////////////////////////////

import 'dart:convert';
import 'package:dsep_bpp/screens/applied_screen_detail.dart';
import 'package:dsep_bpp/utils/colors_widget.dart';
import 'package:dsep_bpp/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import '../provides/ApiServices.dart';

class AppliedScreens extends StatefulWidget {
  const AppliedScreens({Key? key}) : super(key: key);

  @override
  State<AppliedScreens> createState() => _AppliedScreensState();
}

class _AppliedScreensState extends State<AppliedScreens> {
  List response = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    callschemedata();
  }

  // Api call to get all the application list
  void callschemedata() {
    ApiServices().getAppliedSchemes().then((value) {
      setState(() {
        _isLoading = false;

        response = json.decode(value);
      });
    });
  }

  String applicationStatus(String txt) {
    switch (txt) {
      case '0':
        return 'Init';
      case '1':
        return 'Inprogress';
      case '2':
        return 'Awarded';
      case '3':
        return 'Disbursed';
      case '4':
        return 'Closed';
      case '5':
        return 'Rejected';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return PlatformScaffold(
        body: _isLoading ? Loader() : _body(screenHeight, screenWidth));
  }

  List<Widget> listOfAppliedSchmes(double h, double w) {
    List<Widget> a = [];
    for (var i = 0; i < response.length; i++) {
      a.add(GestureDetector(
        onTap: () async {
          var data = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppliedScreenDetails(
                        appId: response[i]['appId'],
                        json: response[i]['applcntDtls'],
                        additionalDetails:
                            jsonDecode(response[i]['addtnlDtls']),
                      )));
          if (data == true) {
            callschemedata();
          }
        },
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(
                color: primaryColor,
                width: 2,
              ),
            ),
            color: Colors.white,
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Application ID :",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          " ${response[i]['appId']}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Applicant Name :",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(" ${response[i]['applcntDtls']['person']['name']}",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Applied Date :",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          " ${dateformatter(response[i]['schemeStartDate'])}",
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Scheme Name :",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 210,
                          child: Text(
                            " ${response[i]['schemeName']}",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Application Status:",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: w * 0.037, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          " ${applicationStatus(response[i]['appStatus'].toString())}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: w * 0.037, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "View Application",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ));
    }
    return a;
  }

  String dateformatter(String dt) {
    DateTime parseDt = DateTime.parse(dt);
    var newFormat = DateFormat("yyyy-MM-dd");
    String updatedDt = newFormat.format(parseDt);
    return updatedDt;
  }

  Widget _body(double h, double w) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
          child: Column(
        children: listOfAppliedSchmes(h, w),
      )),
    );
  }
}
