import 'package:bank_app/pages/home_page/home_page.dart';
import 'package:bank_app/pages/main_page.dart';
import 'package:bank_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
