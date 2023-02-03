import 'package:flutter/material.dart';
import 'package:forme/forme.dart';
import 'package:forme_base_fields/forme_base_fields.dart';
import '../responsive_ui.dart';
import '../form_widgets/validaton_icon.dart';

// ignore: must_be_immutable
class FormCustomDropDown extends StatelessWidget {
  final String name;
  final int order;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color borderColor;
  final Color cursorColor;
  late double cornerRadius;
  late double _width;
  late double _pixelRatio;
  late bool large;
  late bool medium;
  List<String> items;
  late dynamic validator;

  FormCustomDropDown(
      {Key? key,
      required this.name,
      required this.order,
      required this.hint,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.borderColor = Colors.grey,
      this.cursorColor = Colors.blue,
      this.cornerRadius = 15.0,
      required this.items})
      : super(key: key);

  List<DropdownMenuItem<String>> getDropDownItems(List<String> strings) {
    List<DropdownMenuItem<String>> list = <DropdownMenuItem<String>>[];
    for (var i = 0; i < strings.length; i++) {
      list.add(DropdownMenuItem(
        value: strings[i],
        child: Text(strings[i]),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = Responsive.isScreenLarge(_width, _pixelRatio);
    medium = Responsive.isScreenMedium(_width, _pixelRatio);
    return SizedBox(
      child: FormeDropdownButton<String>(
        order: order,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
              borderSide: BorderSide(color: borderColor, width: 0.0)),
        ),
        validator: validator,
        name: name,
        hint: Text(hint),
        items: getDropDownItems(items),
      ),
    );
  }
}
