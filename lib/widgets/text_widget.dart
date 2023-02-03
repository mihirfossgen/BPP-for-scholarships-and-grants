import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final bool? softwrap;
  final TextAlign? alignment;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final String? fontfamily;

  final TextOverflow? overflow;
  final int? maxLines;
  final bool? toUpperCase;
  const TextWidget(
      {Key? key,
      this.text,
      this.size,
      this.color,
      this.weight,
      this.softwrap,
      this.alignment,
      this.decoration,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.toUpperCase,
      this.fontfamily})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String text = this.text ?? "";
    if (toUpperCase == true) {
      text = text.toUpperCase();
    }
    return Text(
      text,
      softWrap: softwrap,
      textAlign: alignment,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
          fontSize: size,
          decoration: decoration,
          color: color,
          fontWeight: weight,
          fontFamily: fontfamily),
    );
  }
}
