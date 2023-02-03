import 'package:flutter/material.dart';
import 'responsive_ui.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  //final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  //final IconData icon;

  late double _width;
  late double _pixelRatio;
  late bool large;
  late bool medium;

  CustomTextField({
    Key? key,
    //required this.hint,
    required this.textEditingController,
    required this.keyboardType,
    // required this.icon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = Responsive.isScreenLarge(_width, _pixelRatio);
    medium = Responsive.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      elevation: large ? 15 : (medium ? 12 : 10),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        obscureText: obscureText,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
