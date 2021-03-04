import 'package:flutter/material.dart';
import 'package:prueba_empleo/tools/colors.dart';

Widget commonAppBar(context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.arrow_back_ios_rounded,
        color: WacoColors.green,
      ),
    ),
  );
}
