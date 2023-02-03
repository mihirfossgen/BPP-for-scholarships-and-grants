import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

class ValidationIcon extends StatelessWidget {
  const ValidationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormeFieldStatusListener<String>(
      filter: (status) => status.isValidationChanged,
      builder: (context, status, child) {
        if (status == null) {
          return const SizedBox.shrink();
        }
        return getIcon(status.validation);
      },
    );
  }

  static Widget getIcon(FormeFieldValidation validation) {
    Widget icon;
    if (validation.isValidating) {
      icon = const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(),
      );
    } else if (validation.isValid) {
      icon = const Icon(
        Icons.check,
        color: Colors.greenAccent,
      );
    } else if (validation.isFail || validation.isInvalid) {
      icon = const Icon(
        Icons.error,
        color: Colors.redAccent,
      );
    } else {
      icon = const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: icon,
    );
  }
}
