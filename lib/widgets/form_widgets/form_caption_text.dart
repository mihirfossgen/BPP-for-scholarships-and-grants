import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormCaptionText extends StatelessWidget {
  List<TextStyle> list = [
    const TextStyle(
        fontWeight: FontWeight.w600, color: Colors.black, fontSize: 15),
    const TextStyle(
        fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 12),
  ];
  String txt;
  int index;
  FormCaptionText(this.txt, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(txt, style: list[index], textAlign: TextAlign.left);
  }
}
