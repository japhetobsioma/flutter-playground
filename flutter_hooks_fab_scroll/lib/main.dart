import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();
  static const title = 'Material App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
