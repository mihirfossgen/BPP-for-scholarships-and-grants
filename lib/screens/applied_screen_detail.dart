////////////////////////////////////////////////////////////
/// Company Name - Fossgen Technologies Pvt Ltd
/// Contact Us - https://fossgentechnologies.com/contact-us/
/// Support - support@fossgentechnologies.com
//////////////////////////////////////////////////////////

import 'package:dsep_bpp/provides/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../utils/colors_widget.dart';
import '../widgets/custom_loader.dart';
import '../widgets/text_widget.dart';

class AppliedScreenDetails extends StatefulWidget {
  final json;
  final additionalDetails;
  final String appId;
  const AppliedScreenDetails(
      {Key? key, this.json, required this.appId, this.additionalDetails})
      : super(key: key);

  @override
  State<AppliedScreenDetails> createState() => _AppliedScreenDetailsState();
}

class _AppliedScreenDetailsState extends State<AppliedScreenDetails> {
  var json;
  bool isLoading = false;
  var address;
  var academicList;
  var currentEducationList;
  var financialstat;
  var tags;
  bool isFamMemWrkng = false;
  var additionalDetail;

  @override
  void initState() {
    super.initState();
    // entire data is obtanied here to show prefilled within the boxes
    json = widget.json;

    if (widget.additionalDetails['isFamMemWrkng'] == 'Y') {
      isFamMemWrkng = true;
      additionalDetail = widget.additionalDetails;
    }
    address = json["contact"]['address'];
    tags = json['person']?['tags'];
    academicList = tags[0]["list"];
    currentEducationList = tags[1]["list"];
    financialstat = tags[2]['list'];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    Widget _title(String value) {
      return Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Row(
          children: [
            Text(
              value,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      );
    }

    String branchName(String txt) {
      switch (txt) {
        case 'mum':
          return 'Mumbai';
        case 'pne':
          return 'Pune';
        case 'bng':
          return 'Pune';
        case 'del':
          return 'Delhi';
        default:
          return '';
      }
    }

    String releationshipName(String txt) {
      switch (txt) {
        case 'M':
          return 'Mother';
        case 'F':
          return 'Father';

        default:
          return '';
      }
    }

    List<Widget> academicQualifationsUi() {
      List<Widget> ui = [];
      for (var i = 0; i < academicList.length; i++) {
        ui.add(Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            _title(academicList[i]['name']),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.black)),
              child: TextWidget(
                text: academicList[i]['value'],
              ),
            ),
          ],
        ));
      }
      return ui;
    }

    List<Widget> currentEducationUi() {
      List<Widget> ui = [];
      for (var i = 0; i < currentEducationList.length; i++) {
        ui.add(Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            _title('Class'),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.black)),
              child: TextWidget(text: currentEducationList[i]['name']),
            ),
            const SizedBox(
              height: 10,
            ),
            _title("Course"),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.black)),
              child: TextWidget(
                text: currentEducationList[i]['value'],
              ),
            ),
          ],
        ));
      }
      return ui;
    }

    List<Widget> financialStatus() {
      List<Widget> ui = [];
      for (var i = 0; i < financialstat.length; i++) {
        ui.add(Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            _title(financialstat[i]['name']),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.black)),
              child: TextWidget(text: financialstat[i]['value']),
            ),
          ],
        ));
      }
      return ui;
    }

    Widget _body(double h, double w) {
      return Container(
        margin: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextWidget(
                text: 'Application Details',
                size: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    _title('Application Id'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: TextWidget(
                        text: json['person']["id"].toString(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _title('Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: TextWidget(
                        text: json['person']['name'].toString(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _title('Gender'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: TextWidget(
                        text: json['person']["gender"].toString(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _title('Academic Qualifications'),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: academicQualifationsUi(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _title('Current Education'),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: currentEducationUi(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _title('Financial Status'),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: financialStatus(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _title(address['format']),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: TextWidget(
                        text: address['full'],
                      ),
                    ),
                    !isFamMemWrkng
                        ? Container()
                        : Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              _title('Additional Info'),
                              const SizedBox(
                                height: 10,
                              ),
                              _title(
                                  'Is your parents working with the organization'),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                padding: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Colors.black)),
                                child: TextWidget(
                                  text: additionalDetail['isFamMemWrkng'] == 'Y'
                                      ? 'Yes'
                                      : '',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              _title('Name of Parent'),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                padding: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Colors.black)),
                                child: TextWidget(
                                  text: additionalDetail['pname'],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              _title('Department Name'),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                padding: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Colors.black)),
                                child: TextWidget(
                                  text: additionalDetail['pdept'],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              _title('Branch'),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                padding: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Colors.black)),
                                child: TextWidget(
                                  text: additionalDetail['pbranch'],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              _title('Branch'),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                padding: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Colors.black)),
                                child: TextWidget(
                                  text: branchName(additionalDetail['pbranch']),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              _title('Relationship with person'),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                padding: const EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Colors.black)),
                                child: TextWidget(
                                  text: releationshipName(
                                      additionalDetail['prel']),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? Loader()
                        : Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: (() {
                                    var data = {
                                      "remarks": "Application is rejected."
                                    };
                                    isLoading = true;
                                    ApiServices()
                                        .rejectApplication(data, widget.appId)
                                        .then((value) {
                                      if (value['status'] == true) {
                                        isLoading = false;
                                        Navigator.pop(context, true);
                                      } else {
                                        isLoading = false;
                                      }
                                    });
                                    setState(() {});
                                  }),
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: const TextWidget(
                                      text: 'Reject',
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: (() {
                                    var data = {
                                      "remarks": "Application is accepted."
                                    };
                                    isLoading = true;
                                    ApiServices()
                                        .acceptApplication(data, widget.appId)
                                        .then((value) {
                                      if (value['status'] == true) {
                                        isLoading = false;
                                        Navigator.pop(context, true);
                                      } else {
                                        isLoading = false;
                                      }
                                    });
                                    setState(() {});
                                  }),
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: const TextWidget(
                                      text: 'Accept',
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      );
    }

    return PlatformScaffold(
        appBar: PlatformAppBar(
          leading: PlatformIconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context, {'details': null}),
          ),
          cupertino: (_, __) => CupertinoNavigationBarData(
            // If this is enabled and set to true then the IconButton above will complain of no parent Material widget
            noMaterialParent: true,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Application Details',
              style: TextStyle(color: Colors.white)),
        ),
        body: _body(screenHeight, screenWidth));
  }
}
