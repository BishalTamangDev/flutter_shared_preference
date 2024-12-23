import 'package:flutter/material.dart';
import 'package:shared_pref_git/constants/constants.dart';
import 'package:shared_pref_git/pages/data_page.dart';
import 'package:shared_pref_git/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  bool boolValue = false;

  @override
  void initState() {
    getPreferenceValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return boolValue ? DataPage() : Home();
  }

  void getPreferenceValues() async {
    var prefs = await SharedPreferences.getInstance();

    setState(() {
      boolValue = prefs.getBool(Constants.boolKey) ?? false;
    });
  }
}
