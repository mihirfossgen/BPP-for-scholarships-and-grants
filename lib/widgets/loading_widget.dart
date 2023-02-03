import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        Container(
          child: Lottie.asset('assets/images/loading.json'),
        ),
        const Text(
          'Loading ...',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
