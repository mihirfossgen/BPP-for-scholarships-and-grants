import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CaptionText extends StatelessWidget {
  List<TextStyle> list = [
    const TextStyle(
        fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 13),
    const TextStyle(
        fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 12),
  ];
  String txt;
  int index;
  CaptionText(this.txt, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Expanded(
    //     child: Text(
    //   txt,
    //   style: list[index],
    // ));
    return Text(txt, style: list[index]);
  }
}
