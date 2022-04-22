import 'package:custompainter/src/pages/AnimacionesPage.dart';
import 'package:custompainter/src/pages/headers_pages.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: AnimacionPage());
  }
}
