import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logioca/common.dart';
import 'package:logioca/models/utente.dart';
import 'package:logioca/pageContainer.dart';
import 'package:logioca/pageProfilo.dart';
import 'package:sizer/sizer_util.dart';
import 'login.dart';

Utente utente = new Utente();
const String geocodingApiKey = "AIzaSyBT2WSx-HE_JXiu5rc-AqB6Z-cDwmd0tfw";

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: viola, statusBarBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation);
            return MaterialApp(
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false, // 1
                  systemOverlayStyle: SystemUiOverlayStyle.light, // 2
                ),
              ),
              debugShowCheckedModeBanner: false,
              home: Scaffold(body: Login()),
            );
          },
        );
      },
    );
  }
}
