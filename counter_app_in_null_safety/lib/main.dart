import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common/constants.dart';
import 'screen/home.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: myAppTitle,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
