import 'package:flutter/material.dart';
import 'dart:io';

class ImagesStep extends StatelessWidget {
  final Function() onPickPassportImage;
  final Function() onPickUtilityBillImage;
  final File? passportImage;
  final File? utilityBillImage;

  const ImagesStep({
    Key? key,
    required this.onPickPassportImage,
    required this.onPickUtilityBillImage,
    required this.passportImage,
    required this.utilityBillImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: onPickPassportImage,
          child: Text(passportImage == null
              ? 'Pick Passport Image'
              : 'Change Passport Image'),
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: onPickUtilityBillImage,
          child: Text(utilityBillImage == null
              ? 'Pick Utility Bill Image'
              : 'Change Utility Bill Image'),
        ),
      ],
    );
  }
}
