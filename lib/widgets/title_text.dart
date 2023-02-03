import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TitleText extends StatelessWidget {
  List<TextStyle> list = [
    const TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.black87,
      fontSize: 14,
      height: 1,
    ),
    const TextStyle(
        fontWeight: FontWeight.w800, color: Colors.blue, fontSize: 13),
    const TextStyle(
        fontWeight: FontWeight.w800, color: Colors.red, fontSize: 13),
  ];
  String txt;
  int index;
  TitleText(this.txt, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: list[index],
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );

    // return Expanded(
    //     child: Text(
    //   txt,
    //   style: list[index],
    // ));
  }
}
