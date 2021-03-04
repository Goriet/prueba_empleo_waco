import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_empleo/models/products_model.dart';
import 'package:prueba_empleo/screens/auth/login_page.dart';
import 'package:prueba_empleo/screens/main/home_page.dart';
import 'package:prueba_empleo/services/database.dart';
import 'package:prueba_empleo/states/current_user.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CurrentUser _user = Provider.of<CurrentUser>(context);
    return (_user.getEmail != null)
        ? StreamProvider<List<Products>>.value(
            value: Database().products, child: HomePage())
        : LoginPage();
  }
}
