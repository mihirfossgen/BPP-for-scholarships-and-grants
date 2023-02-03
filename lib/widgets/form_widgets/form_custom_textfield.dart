import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:forme_base_fields/forme_base_fields.dart';
import '../responsive_ui.dart';
import '../form_widgets/validaton_icon.dart';

// ignore: must_be_immutable
class FormCustomTextField extends StatelessWidget {
  final String name;
  final int order;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final ValidationIcon icon;
  final Color borderColor;
  final Color cursorColor;
  late double cornerRadius;
  late double _width;
  late double _pixelRatio;
  late bool large;
  late bool medium;
  late dynamic validator;
  late String initalValue;
  late bool readOnly;

  FormCustomTextField(
      {Key? key,
      required this.name,
      required this.order,
      required this.hint,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.readOnly = false,
      required this.initalValue,
      required this.icon,
      this.borderColor = Colors.grey,
      this.cursorColor = Colors.blue,
      this.cornerRadius = 15.0,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = Responsive.isScreenLarge(_width, _pixelRatio);
    medium = Responsive.isScreenMedium(_width, _pixelRatio);
    return Platform.isAndroid
        ? FormeTextField(
            name: name,
            order: order,
            keyboardType: keyboardType,
            validator: validator,
            readOnly: readOnly,
            initialValue: initalValue,
            decoration: InputDecoration(
              suffixIcon: icon,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              suffixIconConstraints: const BoxConstraints.tightFor(),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(cornerRadius),
                  borderSide: BorderSide(color: borderColor, width: 0.0)),
              //hintText: hint,
            ),
            cursorColor: cursorColor,
          )
        : SizedBox(
            height: 55,
            child: FormeCupertinoTextField(
              name: name,
              order: order,
              keyboardType: keyboardType,
              validator: validator,
              readOnly: readOnly,
              suffix: icon,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                          cornerRadius) //                 <--- border radius here
                      ),
                  border: Border.all(color: borderColor)),
              cursorColor: cursorColor,
            ),
          );
  }
}
