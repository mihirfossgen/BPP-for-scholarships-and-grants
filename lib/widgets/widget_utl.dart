import './dotted_line.dart';
import './title_text.dart';
import 'package:flutter/cupertino.dart';

class WidgetUtl {
  static getVerticalSpace() {
    return const SizedBox(height: 10);
  }

  static getLine() {
    return const Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: DottedLine(), //DottedLine(),
    ); // DottedLine()
  }

  static getNoDataFound() {
    return SizedBox(
      height: 100,
      child: Center(
        child: TitleText("No data found.", 2),
      ),
    );
  }
}
