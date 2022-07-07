
import 'package:bmi_ca/modules/login/login2.dart';
import 'package:bmi_ca/modules/messenger/Messenger.dart';

import 'layout/home_layout/home_layout.dart';
import 'modules/listviews/Test1.dart';
import 'modules/calculator/calculator.dart';
import 'package:flutter/material.dart';

import 'modules/login/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:HomeLayout(),
    );
  }
}


