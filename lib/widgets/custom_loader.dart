import 'package:dsep_bpp/utils/colors_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'spinkit_three_bounce_loader.dart';

class Loader extends StatelessWidget {
  final Color? color;
  Loader({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: const Center(
            child: SpinKitThreeBounce(
          color: primaryColor,
        )));
  }
}
