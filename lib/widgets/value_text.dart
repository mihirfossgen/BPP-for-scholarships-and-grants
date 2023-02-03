import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ValueText extends StatelessWidget {
  List<TextStyle> list = [
    const TextStyle(
        fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),
    const TextStyle(
        fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 14),
  ];
  String txt;
  int index;
  ValueText(this.txt, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Expanded(
    //     child: Text(
    //   txt,
    //   style: list[index],
    // ));

    return Text(
      txt,
      style: list[index],
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
