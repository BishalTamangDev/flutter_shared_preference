import 'package:flutter/material.dart';
import 'package:shared_pref_git/pages/check.dart';
import 'package:shared_pref_git/pages/home.dart';

void main() {
  runApp(const SharedPrefApp());
}

class SharedPrefApp extends StatelessWidget {
  const SharedPrefApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Share Preference App",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: Check(),
    );
  }
}
