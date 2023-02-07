////////////////////////////////////////////////////////////
/// Company Name - Fossgen Technologies Pvt Ltd
/// Contact Us - https://fossgentechnologies.com/contact-us/
/// Support - support@fossgentechnologies.com
//////////////////////////////////////////////////////////

import 'dart:convert';
import 'package:dsep_bpp/screens/create_scheme_screen.dart';
import 'package:dsep_bpp/widgets/custom_loader.dart';
import 'package:dsep_bpp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import '../utils/api.dart';
import '../utils/colors_widget.dart';
import '../utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dsep_bpp/provides/ApiServices.dart';

class HomePage extends StatefulWidget {
  int? value;
  HomePage({Key? key, this.value}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = -1;
  Widget? screenView;
  String selectedSchemeType = "";
  String selectedStatus = "";
  String selectedStartDate = "";
  String selectedEndDate = "";
  bool schemeTypeSelectedStatus = false;
  bool statusSelectedStatus = false;
  bool startDateSelectedStatus = false;
  bool endDateSelectedStatus = false;
  var color = 0xffe3f2fd;

  bool _isloading = false; // used to show the loader animation
  bool _isExpand = false;

  var schemeData;
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();

  startShowCase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //here we are setting the boolean value true to show case only for fresh installed
    if (prefs.getBool("first_login") == null) {
      prefs.setBool("first_login", true);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Future.delayed(
          const Duration(milliseconds: 400),
          () {
            ShowCaseWidget.of(context).startShowCase([_two, _three]);
          },
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _isloading = true;
    getAllSchemeList(); // api called to get all schemes that are created

    if (Global.isfirstlogin == true) {
    } else {
      startShowCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenFontMedium = screenHeight * 0.017;
    final screenFontSmall = screenHeight * 0.014;

    var i = 0;

    return SafeArea(
      top: false,
      child: Scaffold(
          floatingActionButton: Showcase(
            key: _two,
            title: 'Create Schema',
            description: 'Click here to create schemas',
            shapeBorder: const CircleBorder(),
            overlayPadding: const EdgeInsets.all(10),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateSchemeScreen(
                          routeFrom: "home",
                        )));
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          ),
          body: _body(screenFontSmall, screenWidth)),
    );
  }

  Widget _body(double screenFontSmall, double screenWidth) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Column(
        children: [
          Expanded(
              child: Showcase(
            key: _three,
            description: 'List of all created schemas',
            overlayPadding: const EdgeInsets.all(10),
            child: _isloading
                ? Loader()
                : schemeData == null
                    ? Container(
                        alignment: Alignment.center,
                        child: const TextWidget(
                          text: "No schemes created",
                          size: 15,
                          weight: FontWeight.bold,
                        ),
                      )
                    : ReusbaleRow(
                        indexOnject: schemeData,
                        optionTypeSelect:
                            (String selectedOption, int index) async {
                          if (selectedOption == "Publish") {
                            var result =
                                await FlutterPlatformAlert.showCustomAlert(
                              windowTitle: 'Do you want to Publish this?',
                              text: '',
                              positiveButtonTitle: "Yes",
                              negativeButtonTitle: "No",
                              options: FlutterPlatformAlertOption(
                                  additionalWindowTitleOnWindows:
                                      'Window title',
                                  showAsLinksOnWindows: true),
                            );

                            if (result == CustomButton.positiveButton) {
                              var data = {};
                              ApiServices()
                                  .publishScheme(
                                      data, schemeData[index]["schemeID"])
                                  .then((value) {
                                if (value["status"] == true) {
                                  schemeData[index]["published"] = true;
                                  setState(() {});
                                  Fluttertoast.showToast(
                                      msg: "Scheme Published SuccessFully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Failed To Publish Scheme...Try After Sometime",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              });
                            }
                          } else if (selectedOption == "UnPublish") {
                            var result =
                                await FlutterPlatformAlert.showCustomAlert(
                              windowTitle: 'Do you want to UnPublish this?',
                              text: '',
                              positiveButtonTitle: "Yes",
                              negativeButtonTitle: "No",
                              options: FlutterPlatformAlertOption(
                                  additionalWindowTitleOnWindows:
                                      'Window title',
                                  showAsLinksOnWindows: true),
                            );

                            if (result == CustomButton.positiveButton) {
                              var data = {};
                              ApiServices()
                                  .unpublishScheme(
                                      data, schemeData[index]["schemeID"])
                                  .then((value) {
                                if (value["status"] == true) {
                                  schemeData[index]["published"] = false;
                                  setState(() {});
                                  Fluttertoast.showToast(
                                      msg: "Scheme unPublished SuccessFully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Failed To Publish Scheme...Try After Sometime",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              });
                            }
                          } else if (selectedOption == "Edit") {
                            var result =
                                await FlutterPlatformAlert.showCustomAlert(
                              windowTitle: 'Do you want to Edit this?',
                              text: '',
                              positiveButtonTitle: "Yes",
                              negativeButtonTitle: "No",
                              options: FlutterPlatformAlertOption(
                                  additionalWindowTitleOnWindows:
                                      'Window title',
                                  showAsLinksOnWindows: true),
                            );

                            if (result == CustomButton.positiveButton) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CreateSchemeScreen(
                                        routeFrom: "update",
                                        data: schemeData[index],
                                      )));
                            }
                          } else if (selectedOption == "Delete") {
                            var result =
                                await FlutterPlatformAlert.showCustomAlert(
                              windowTitle: 'Do you want to delete this?',
                              text: '',
                              positiveButtonTitle: "Yes",
                              negativeButtonTitle: "No",
                              options: FlutterPlatformAlertOption(
                                  additionalWindowTitleOnWindows:
                                      'Window title',
                                  showAsLinksOnWindows: true),
                            );
                            if (result == CustomButton.positiveButton) {
                              var data = {};
                              ApiServices()
                                  .Delete(data, schemeData[index]["schemeID"])
                                  .then((value) {
                                if (value["status"] == true) {
                                  schemeData[index]["deleted"] = true;
                                  setState(() {});
                                  Fluttertoast.showToast(
                                      msg: "Scheme Deleted SuccessFully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Failed To Delete Scheme...Try After Sometime",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              });
                            }
                          }
                        }),
          )),
        ],
      ),
    );
  }

  updateId(String schemeType, String status, String startDate, String endDate) {
    // _searchResult.clear();

    if (schemeType != "Select any option") {
      setState(() {
        selectedSchemeType = schemeType;
        schemeTypeSelectedStatus = true;
      });
    } else {
      setState(() {
        selectedSchemeType = "";
        schemeTypeSelectedStatus = false;
      });
    }
    if (status != "Select any option") {
      setState(() {
        selectedStatus = status;
        statusSelectedStatus = true;
      });
    } else {
      setState(() {
        selectedStatus = "";
        statusSelectedStatus = false;
      });
    }
    if (startDate != "Start Date") {
      setState(() {
        selectedStartDate = startDate;
        startDateSelectedStatus = true;
      });
    } else {
      setState(() {
        selectedStartDate = "";
        startDateSelectedStatus = false;
      });
    }
    if (endDate != "End Date") {
      setState(() {
        selectedEndDate = endDate;
        endDateSelectedStatus = true;
      });
    } else {
      setState(() {
        selectedEndDate = "";
        endDateSelectedStatus = false;
      });
    }
  }

  getAllSchemeList() {
    ApiServices().homeApi().then((value) {
      setState(() {
        _isloading = false;
      });
      schemeData = json.decode(value);
    });
  }
}

typedef void StringCallback(String selectedOption, int index);

class ReusbaleRow extends StatefulWidget {
  var indexOnject;

  final StringCallback optionTypeSelect;
  ReusbaleRow(
      {Key? key, required this.indexOnject, required this.optionTypeSelect})
      : super(key: key);

  @override
  State<ReusbaleRow> createState() => _ReusbaleRowState();
}

class _ReusbaleRowState extends State<ReusbaleRow> {
  bool publish = false;
  static bool _isExpand = false;
  static var map = <int, bool>{};
  static bool _isiterateflag = true;
  List a = [];

  DateTime dateformatter1(int dt) {
    var date = DateTime.fromMicrosecondsSinceEpoch(dt);
    DateTime parseDt = DateTime.parse(date.toString());
    return parseDt;
  }

  @override
  void initState() {
    super.initState();
    a = widget.indexOnject;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    if (_isiterateflag) {
      for (var i = 0; i <= a.length; i++) {
        map.putIfAbsent(i, () => false);
      }
      _isiterateflag = false;
    }

    return ListView.builder(
        itemCount: a.length,
        itemBuilder: (context2, index) {
          return Padding(
            padding: widget.indexOnject[index]['deleted']
                ? const EdgeInsets.only(top: 0)
                : const EdgeInsets.only(top: 10),
            child: widget.indexOnject[index]['deleted']
                ? Container(
                    height: 0,
                  )
                : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: const BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 18, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/default_profile.jpeg',
                                width: screenWidth * 0.13,
                                height: screenHeight * 0.07,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SizedBox(
                                  width: screenWidth * 0.55,
                                  child: Text(
                                    widget.indexOnject[index]['schemeName']
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.037,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder: (ctx) => [
                                  widget.indexOnject[index]['published']
                                      ? PopupMenuItem(
                                          child: const Text(
                                            "UnPublish",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onTap: () {
                                            widget.optionTypeSelect(
                                                "UnPublish", index);
                                          },
                                        )
                                      : PopupMenuItem(
                                          child: const Text(
                                            "Publish",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          onTap: () {
                                            widget.optionTypeSelect(
                                                "Publish", index);
                                          },
                                        ),
                                  PopupMenuItem(
                                    child: const Text("Edit"),
                                    onTap: () {
                                      widget.optionTypeSelect("Edit", index);
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: const Text("Delete"),
                                    onTap: () {
                                      widget.optionTypeSelect("Delete", index);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Status  ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ":  " +
                                                (widget.indexOnject[index]
                                                        ['published']
                                                    ? "Published"
                                                    : "Unpublished"),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: widget.indexOnject[index]
                                                        ['published']
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "ScholarShip Amount ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ":  " +
                                                widget.indexOnject[index]
                                                        ['schemeAmount']
                                                    .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Scheme Type ",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ": " +
                                                widget.indexOnject[index]
                                                        ['schemeType']
                                                    .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Scheme For  ",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ": " +
                                                widget.indexOnject[index]
                                                        ['schemeFor']
                                                    .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Applicable For Financial Year ",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ": " +
                                                widget.indexOnject[index]
                                                        ['financialYear']
                                                    .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Start Date",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ": ${widget.indexOnject[index]['startDate']} ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 8,
                                      left: 12,
                                      right: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "End Date",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.037,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            ": ${widget.indexOnject[index]['endDate']}",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ],
                                  )),
// /---------------------------------------------------------------------------------
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: TextButton(
                                      // ignore: unnecessary_cast
                                      child: map[index] as bool
                                          ? Container(
                                              height: 0,
                                            )
                                          : const Text(
                                              "Read More",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                      onPressed: () {
                                        setState(() {
                                          map.update(index, (value) => true);
                                        });
                                      },
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: map[index] as bool ? 430 : 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: TextButton(
                                      child: const Text(
                                        "Eligiblity Criteria (Academics)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {},
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Minimum Graduation Level Required ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              ": " +
                                                  widget.indexOnject[index]
                                                          ["eligibility"]
                                                          ["acadDtls"][0]
                                                          ["courseLevelName"]
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Accepted Score Type ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              ": " +
                                                  widget.indexOnject[index]
                                                          ["eligibility"]
                                                          ["acadDtls"][0]
                                                          ["scoreType"]
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Minimum Score Required ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              ": " +
                                                  widget.indexOnject[index]
                                                          ["eligibility"]
                                                          ["acadDtls"][0]
                                                          ["scoreValue"]
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Passing Year ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              ": " +
                                                  widget.indexOnject[index]
                                                          ["eligibility"]
                                                          ["acadDtls"][0]
                                                          ["passingYear"]
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    )),
                                const Padding(
                                    padding:
                                        EdgeInsets.only(top: 12.0, bottom: 12),
                                    child: Text(
                                      "Eligibility Criteria (Other)",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Minimum Age Required ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              ": " +
                                                  widget.indexOnject[index]
                                                          ["eligibility"]["age"]
                                                      .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Gender ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                Text(
                                                  ": ",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.037,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  widget.indexOnject[index]
                                                              ["eligibility"]
                                                          ["gender"] ??
                                                      'NA',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.037,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            )),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 10,
                                        left: 12,
                                        right: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Family Income  ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.037,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              ": ${widget.indexOnject[index]["eligibility"]["familyIncome"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextButton(
                                      child: const Text(
                                        "Read less",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          map.update(index, (value) => false);
                                        });
                                      },
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
          );
        });
  }
}
