import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:forme_base_fields/forme_base_fields.dart';
import '../responsive_ui.dart';

// ignore: must_be_immutable
class FormCustomDatePicker extends StatelessWidget {
  final String name;
  final int order;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final DateTime? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final IconData icon;
  final Color borderColor;
  final Color cursorColor;
  late double cornerRadius;
  late double _width;
  late double _pixelRatio;
  late bool large;
  late bool medium;
  late dynamic validator;

  FormCustomDatePicker(
      {Key? key,
      required this.name,
      required this.order,
      required this.hint,
      this.validator,
      required this.firstDate,
      required this.lastDate,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.initialValue,
      required this.icon,
      this.borderColor = Colors.grey,
      this.cursorColor = Colors.blue,
      this.cornerRadius = 20.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = Responsive.isScreenLarge(_width, _pixelRatio);
    medium = Responsive.isScreenMedium(_width, _pixelRatio);
    return Platform.isAndroid
        ? FormeDateTimeField(
            name: name,
            order: order,
            initialValue: initialValue,
            validator: validator,
            firstDate: firstDate,
            lastDate: lastDate,
            helpText: hint,
            autovalidateMode: AutovalidateMode.always,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(cornerRadius),
                  borderSide: BorderSide(color: borderColor, width: 0.0)),
              suffixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.calendar_month),
              ),
              suffixIconConstraints: const BoxConstraints.tightFor(),
            ),
          )
        : SizedBox(
            height: 50,
            child: FormeCupertinoDateTimeField(
              name: name,
              order: order,
              validator: validator,
              minimumDate: firstDate,
              maximumDate: lastDate,
              autovalidateMode: AutovalidateMode.always,
              suffix: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.calendar_month, color: cursorColor, size: 20),
              ),
              placeholderStyle: TextStyle(color: borderColor),
              initialValue: initialValue,
              placeholder: hint,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                          cornerRadius) //                 <--- border radius here
                      ),
                  border: Border.all(color: borderColor)),
            ),
          );
  }
}
