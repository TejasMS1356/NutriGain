import 'package:flutter/material.dart';
import 'package:protiencaluclator/fooddetails_page.dart';
import 'package:protiencaluclator/home_page.dart';
import 'package:protiencaluclator/global_varialbles.dart';
import 'package:protiencaluclator/fooddetails_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrigain',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 127, 146, 214),
          primary: Color.fromARGB(255, 105, 122, 179),
        ),
      ),
      home: HomePage(),
    );
  }
}
