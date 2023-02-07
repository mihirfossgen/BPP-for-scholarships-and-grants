////////////////////////////////////////////////////////////
/// Company Name - Fossgen Technologies Pvt Ltd
/// Contact Us - https://fossgentechnologies.com/contact-us/
/// Support - support@fossgentechnologies.com
//////////////////////////////////////////////////////////

import 'package:dsep_bpp/utils/colors_widget.dart';
import 'package:dsep_bpp/widgets/text_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../widgets/form_widgets/validaton_icon.dart';
import './../widgets/form_widgets/form_caption_text.dart';
import '../widgets/form_widgets/form_custom_textfield.dart';
import '../models/create_scheme_model.dart';
import './../widgets/title_text.dart';
import './../widgets/value_text.dart';
import '../widgets/responsive_ui.dart';

class AddEligibility extends StatefulWidget {
  final String routeFrom;
  final String selectedSchemeFor;
  var data;
  var spocdata;
  AddEligibility(
      {Key? key,
      required this.routeFrom,
      required this.selectedSchemeFor,
      this.spocdata,
      this.data})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddEligibilityState();
}

class _AddEligibilityState extends State<AddEligibility> {
  late double _height;
  late double _width;
  late double _pixelRatio;
  late bool _large;
  late bool _medium;
  late double _bottom;
  late double _top;
  final FormeKey formKey = FormeKey();
  bool switchValue = false;
  int courseDetailsIndex = 0;
  List<_EligibilityDetails> eligibilityDetailsWidgets = [];
  List<PastEducation> details = [];
  Eligibility eligibility = Eligibility();
  int _index = 0;
  var data;
  int academicCount = 1;
  var spocData;
  bool routeForUpdate = false;
  List<TextEditingController> courseLevelName = [];
  List<TextEditingController> courseName = [];
  List<TextEditingController> scoreValue = [];
  List<TextEditingController> passingYear = [];
  static TextEditingController gender = TextEditingController();
  static TextEditingController familyIncome = TextEditingController();
  static TextEditingController caste = TextEditingController();
  List<TextEditingController> scoreType = [];

  void getUpdatedValueAndSubmitForm(Map<String, dynamic> values) {
    values['Family Income'] = familyIncome.text;
    values['Gender'] = gender.text;
    values['caste'] = caste.text;
    List list = [];
    for (var i = 0; i < academicCount; i++) {
      list.add({
        "courseLevelName": courseLevelName[i].text,
        "courseName": courseName[i].text,
        "scoreType": scoreType[i].text,
        "scoreValue": scoreValue[i].text,
        "passingYear": passingYear[i].text
      });
    }
    values['academicDetails'] = list;

    eligibility = Eligibility(
        caste: values['Caste'],
        familyIncome: values['Family Income'],
        gender: values['Gender'],
        academicDetails: values['academicDetails'],
        courseLevelID: values['Course Level ID'],
        courseName: values['Course Name'],
        scoreType: values['Score Type'],
        spocName: values['Spoc Name'],
        spocEmail: values['Spoc Email'],
        helpdeskNo: values['Help Desk No'],
        passingYear: values['Passing Year'],
        addtnlInfoReq: switchValue);
    Navigator.pop(context, {'details': eligibility});
  }

  List a = [];
  List<String> courseLevelNameList = [];

  @override
  void initState() {
    super.initState();
    if (widget.routeFrom == "update") {
      routeForUpdate = true;
      spocData = widget.spocdata;
      switchValue = spocData['addtnlInfoReq'];
      data = widget.data;
      gender.text = data['gender'] ?? "NA";
      familyIncome.text = data['familyIncome'] ?? 'Not Mandatory';
      caste.text = data['caste'] ?? "";
      a = data['acadDtls'];
      academicCount = a.length;
    } else {
      gender.text = "";
      familyIncome.text = "";
    }
    if (widget.selectedSchemeFor == "pg") {
      courseLevelNameList = ['Under Graduate', 'Grade'];
    } else if (widget.selectedSchemeFor == "ug") {
      courseLevelNameList = ['Grade'];
    } else {
      courseLevelNameList = ['Grade'];
    }

    initalData();
  }

  void initalData() {
    if (academicCount != a.length) {
      courseLevelName.add(TextEditingController());
      courseName.add(TextEditingController());
      scoreType.add(TextEditingController());
      scoreValue.add(TextEditingController());
      passingYear.add(TextEditingController());
    } else if (widget.routeFrom == "update") {
      for (var i = 0; i < academicCount; i++) {
        courseLevelName.add(TextEditingController(
            text: data['acadDtls']?[i]['courseLevelName'] ?? ""));
        courseName.add(TextEditingController(
            text: data['acadDtls']?[i]['courseName'] ?? ""));
        scoreType.add(TextEditingController(
            text: data['acadDtls']?[i]['scoreType'] ?? ""));
        scoreValue.add(TextEditingController(
            text: data['acadDtls']?[i]['scoreValue'] ?? ""));
        passingYear.add(TextEditingController(
            text: data['acadDtls']?[i]['passingYear'] ?? ""));
      }
    }
  }

  List<Widget> loadFormFieldSection() {
    final children = <Widget>[];
    Widget widget = Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 12,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Gender', 0),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext bc) {
                              return Bottomsheet(
                                onchanged: ((value) {
                                  gender.text = value;
                                  setState(() {});
                                }),
                                values: const ['Male', 'Female', 'Other', 'NA'],
                                selectedvalue: gender.text,
                              );
                            });
                      },
                      child: AbsorbPointer(
                          child: TextFormField(
                        controller: gender,
                        decoration: InputDecoration(
                          suffixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIconConstraints:
                              const BoxConstraints.tightFor(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 0.0)),
                        ),
                      )),
                    ))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Family Income', 0),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext bc) {
                              return Bottomsheet(
                                onchanged: ((value) {
                                  familyIncome.text = value;
                                  setState(() {});
                                }),
                                values: const [
                                  'less than 100000',
                                  '100000 to 500000',
                                  'more than 500000',
                                  'Not Mandatory'
                                ],
                                selectedvalue: familyIncome.text,
                              );
                            });
                      },
                      child: AbsorbPointer(
                          child: TextFormField(
                        controller: familyIncome,
                        decoration: InputDecoration(
                          suffixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIconConstraints:
                              const BoxConstraints.tightFor(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 0.0)),
                        ),
                      )),
                    ))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: FormCaptionText('Caste', 0),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext bc) {
                              return Bottomsheet(
                                onchanged: ((value) {
                                  caste.text = value;
                                  setState(() {});
                                }),
                                values: const ['General', 'OBC', 'SC', 'ST'],
                                selectedvalue: familyIncome.text,
                              );
                            });
                      },
                      child: AbsorbPointer(
                          child: TextFormField(
                        controller: familyIncome,
                        decoration: InputDecoration(
                          suffixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIconConstraints:
                              const BoxConstraints.tightFor(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 0.0)),
                        ),
                      )),
                    ))
              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 20.0),
                child: TextWidget(
                  text: 'Academic Details',
                  size: 25,
                  weight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                Column(
                  children: acedemicDeatils(),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    academicCount++;
                    initalData();
                    setState(() {});
                  },
                  child: AbsorbPointer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add, color: primaryColor, size: 20),
                        TextWidget(
                          text: "Press to add extra academic details",
                          color: primaryColor,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 10.0, top: 20.0),
                    child: TextWidget(
                      text: 'Additional Information',
                      size: 25,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 15.0),
                      child: FormCaptionText('Spoc Name', 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: FormCustomTextField(
                                name: "Spoc Name",
                                order: 4,
                                hint: '',
                                initalValue:
                                    routeForUpdate ? spocData['spocName'] : "",
                                validator:
                                    FormeValidates.notEmpty(errorText: ''),
                                keyboardType: TextInputType.name,
                                cornerRadius: 15.0,
                                cursorColor: Colors.blue,
                                borderColor: Colors.grey,
                                icon: const ValidationIcon()),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 15.0),
                      child: FormCaptionText('Spoc Email', 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: FormCustomTextField(
                                initalValue:
                                    routeForUpdate ? spocData['spocEmail'] : "",
                                name: 'Spoc Email',
                                order: 4,
                                hint: '',
                                validator:
                                    FormeValidates.notEmpty(errorText: ''),
                                keyboardType: TextInputType.name,
                                cornerRadius: 15.0,
                                cursorColor: Colors.blue,
                                borderColor: Colors.grey,
                                icon: const ValidationIcon()),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 10.0, top: 15.0),
                      child: FormCaptionText('Help Desk No', 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: FormCustomTextField(
                                initalValue: routeForUpdate
                                    ? spocData['helpdeskNo']
                                    : "",
                                name: 'Help Desk No',
                                order: 9,
                                hint: 'Min',
                                validator:
                                    FormeValidates.notEmpty(errorText: ''),
                                keyboardType: TextInputType.number,
                                cornerRadius: 15.0,
                                cursorColor: Colors.blue,
                                borderColor: Colors.grey,
                                icon: const ValidationIcon()),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(
                        text: 'Additional Infromation \nRequired',
                      ),
                      Row(
                        children: [
                          const TextWidget(
                            text: 'No',
                          ),
                          Switch(
                            value: switchValue,
                            activeColor: primaryColor,
                            onChanged: (value) {
                              switchValue = value;
                              setState(() {});
                            },
                          ),
                          const TextWidget(
                            text: 'Yes',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: eligibilityDetailsWidgets.map((e) => e.widget).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
    setState(() {
      children.add(widget);
    });
    return children;
  }

  List<Widget> acedemicDeatils() {
    List<Widget> _list = [];
    for (var i = 0; i < academicCount; i++) {
      _list.add(Stack(
        children: [
          i == 0
              ? Container()
              : Positioned(
                  height: 40,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        courseLevelName.remove(TextEditingController());
                        courseName.remove(TextEditingController());
                        scoreType.remove(TextEditingController());
                        scoreValue.remove(TextEditingController());
                        passingYear.remove(TextEditingController());
                        academicCount--;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: SvgPicture.asset('assets/images/delete.svg',
                          height: 30,
                          fit: BoxFit.fill,
                          color: greyColor.shade400),
                    ),
                  ),
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title('Course Level Name'),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      showModalBottomSheet<dynamic>(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext bc) {
                            return Bottomsheet(
                              onchanged: ((value) {
                                courseLevelName[i].text = value;
                                setState(() {});
                              }),
                              values: courseLevelNameList,
                              selectedvalue: courseLevelName[i].text,
                            );
                          });
                    },
                    child: AbsorbPointer(
                        child: TextFormField(
                      controller: courseLevelName[i],
                      decoration: InputDecoration(
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:
                              Icon(Icons.arrow_drop_down, color: Colors.black),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIconConstraints: const BoxConstraints.tightFor(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 0.0)),
                      ),
                    )),
                  )),
              _title('Course Name'),
              _textFields(courseName[i]),
              _title('Score Type'),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      showModalBottomSheet<dynamic>(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext bc) {
                            return Bottomsheet(
                              onchanged: ((value) {
                                scoreType[i].text = value;
                                setState(() {});
                              }),
                              values: const [
                                'Percentage',
                                'CGPA',
                              ],
                              selectedvalue: scoreType[i].text,
                            );
                          });
                    },
                    child: AbsorbPointer(
                        child: TextFormField(
                      controller: scoreType[i],
                      decoration: InputDecoration(
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:
                              Icon(Icons.arrow_drop_down, color: Colors.black),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIconConstraints: const BoxConstraints.tightFor(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 0.0)),
                      ),
                    )),
                  )),
              _title('Score value'),
              _textFields(scoreValue[i]),
              _title('Passing Year'),
              _textFields(passingYear[i])
            ],
          )
        ],
      ));
    }
    return _list;
  }

  Widget _title(String text) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0),
        child: TextWidget(
          alignment: TextAlign.left,
          text: text,
          size: 15,
          color: Colors.black,
          weight: FontWeight.w600,
        ));
  }

  Widget _textFields(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.blue, width: 0.0)),
        ),
      ),
    );
  }

  InputBorder? getEnabledBorder(FormeFieldValidation? validation,
      {double width = 1}) {
    return (validation?.isInvalid ?? false)
        ? OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error, width: width),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = Responsive.isScreenLarge(_width, _pixelRatio);
    _medium = Responsive.isScreenMedium(_width, _pixelRatio);
    _bottom = MediaQuery.of(context).viewPadding.bottom;
    _top = MediaQuery.of(context).viewPadding.top;
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
        title: const Text('Add Eligibility',
            style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Forme(
              autovalidateByOrder: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: <Widget>[
                    for (var item in loadFormFieldSection())
                      Container(child: item),
                    const SizedBox(height: 10),
                    routeForUpdate
                        ? Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: FormeIsValueChangedListener(
                                      builder: (context, isValueChanged) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: secondaryColor),
                                      onPressed:
                                          isValueChanged ? formKey.reset : null,
                                      child: const Text('Reset'),
                                    );
                                  }),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: FormeValidationListener(
                                      builder: (context, validation, child) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        getUpdatedValueAndSubmitForm(
                                            formKey.value);
                                      },
                                      child: const Text('Submit'),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: FormeIsValueChangedListener(
                                      builder: (context, isValueChanged) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: secondaryColor),
                                      onPressed:
                                          isValueChanged ? formKey.reset : null,
                                      child: const Text('Reset'),
                                    );
                                  }),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: FormeValidationListener(
                                      builder: (context, validation, child) {
                                    return ElevatedButton(
                                      onPressed: validation.isValid
                                          ? () {
                                              getUpdatedValueAndSubmitForm(
                                                  formKey.value);
                                            }
                                          : null,
                                      child: const Text('Submit'),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void appendDetails(List<PastEducation> eDetails) {
    for (var item in eDetails) {
      details.add(item);
    }
    final Widget widget = SizedBox(
      height: 350,
      width: _width / 0.05,
      child: ListView.builder(
          itemCount: details.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12, left: 12),
                          child: Text(
                            'Qualification Details',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        SizedBox(
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  details.remove(details[index]);
                                  courseDetailsIndex = details.length;
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.blue,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TitleText(
                            ('Course Level ID:'),
                            0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: ValueText(
                            (details[index].courseLevelID ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TitleText(
                            ('Course Level Name:'),
                            0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: ValueText(
                            (details[index].courseLevelName ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TitleText(
                            ('Course ID:'),
                            0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: ValueText(
                            (details[index].courseID ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TitleText(
                            ('Course Name:'),
                            0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: ValueText(
                            (details[index].courseName ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TitleText(
                            ('Institute Name:'),
                            0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: ValueText(
                            (details[index].instituteName ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TitleText(
                            ('Institute State:'),
                            0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: ValueText(
                            (details[index].instituteState ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TitleText(
                            ('UniversityOrBoard:'),
                            0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: ValueText(
                            (details[index].universityOrBoard ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TitleText(
                            ('Score Type:'),
                            0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: ValueText(
                            (details[index].scoreType ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 10),
                          child: TitleText(
                            ('Score Value:'),
                            0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 10),
                          child: ValueText(
                            (details[index].scoreValue ?? ''),
                            0,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
    setState(() {
      eligibilityDetailsWidgets = [_EligibilityDetails(widget)];
    });
  }

  void _showerrorDialog(BuildContext dialogContext, String message) {
    showPlatformDialog(
      context: dialogContext,
      builder: (_) => PlatformAlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: <Widget>[
          PlatformDialogAction(
            material: (_, __) => MaterialDialogActionData(),
            cupertino: (_, __) => CupertinoDialogActionData(),
            child: PlatformText('Cancel'),
            onPressed: () => Navigator.pop(dialogContext),
          ),
          PlatformDialogAction(
            child: PlatformText('OK'),
            onPressed: () => Navigator.pop(dialogContext),
          ),
        ],
      ),
    );
  }
}

class _EligibilityDetails {
  final Widget widget;
  _EligibilityDetails(this.widget);
}

class Bottomsheet extends StatefulWidget {
  final List<String> values;
  final selectedvalue;
  final Function(dynamic) onchanged;
  Bottomsheet(
      {Key? key,
      required this.values,
      this.selectedvalue,
      required this.onchanged})
      : super(key: key);

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  @override
  void initState() {
    value = widget.selectedvalue;

    values = widget.values;

    super.initState();
  }

  String value = "";
  List<String> values = [];
  @override
  Widget build(BuildContext context) {
    List<Widget> sizelist() {
      List<Widget> products = [];
      for (var i = 0; i < (values.length); i++) {
        products.add(GestureDetector(
          onTap: () {
            value = values[i];

            widget.onchanged(value);

            setState(() {});
            Navigator.pop(context);
          },
          child: Container(
            height: 45,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade300))),
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.black)),
                      child: value == ""
                          ? Container()
                          : value == values[i]
                              ? Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: secondaryColor),
                                )
                              : Container(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextWidget(
                      text: values[i],
                      color: Colors.black,
                      size: 15,
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ));
      }
      return products;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            color: secondaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.clear,
                      size: 25,
                      color: whiteColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Container(
                  alignment: Alignment.center,
                  child: const TextWidget(
                    text: "Select ...",
                    color: whiteColor,
                    size: 15,
                    weight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 30,
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sizelist(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
