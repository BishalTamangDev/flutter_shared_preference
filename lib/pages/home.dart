import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_pref_git/constants/constants.dart';
import 'package:shared_pref_git/pages/data_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // controllers
  var boolController = TextEditingController();
  var intController = TextEditingController();
  var doubleController = TextEditingController();
  var stringController = TextEditingController();
  var stringListController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            spacing: 16.0,
            children: [
              const SizedBox(height: 16.0),

              // string :: username
              TextField(
                autofocus: false,
                controller: stringController,
                decoration: InputDecoration(
                  filled: true,
                  label: Text("Username"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // int :: age
              TextField(
                autofocus: false,
                controller: intController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  label: Text("Age"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // double :: goa
              TextField(
                autofocus: false,
                controller: doubleController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  label: Text("GPA"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // string list
              TextField(
                autofocus: false,
                controller: stringListController,
                decoration: InputDecoration(
                  filled: true,
                  label: Text("String list"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // submit
              ElevatedButton(
                onPressed: () async {
                  bool set = false;
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  // string
                  if (stringController.text.isNotEmpty) {
                    //   set string pref
                    prefs.setString(
                        Constants.stringKey, stringController.text.toString());
                    set = true;
                  }

                  // integer
                  if (intController.text.isNotEmpty) {
                    try {
                      int intVal = int.parse(intController.text.toString());
                      prefs.setInt(Constants.intKey, intVal);
                      set = true;
                    } catch (ex) {
                      if (context.mounted) {
                        if (ScaffoldMessenger.of(context).mounted) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: const Text(
                                "Please enter the correct integer value."),
                          ),
                        );
                        return;
                      }
                    }
                  }

                  // double
                  if (doubleController.text.isNotEmpty) {
                    try {
                      double doubleVal =
                          double.parse(doubleController.text.toString());
                      prefs.setDouble(Constants.doubleKey, doubleVal);
                      set = true;
                    } catch (ex) {
                      if (context.mounted) {
                        if (ScaffoldMessenger.of(context).mounted) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: const Text(
                                "Please enter the correct double input."),
                          ),
                        );
                        return;
                      }
                    }
                  }

                  // string list
                  if (stringListController.text.isNotEmpty) {
                    var list = stringListController.text.toString().split(',');
                    prefs.setStringList(Constants.stringListKey, list);
                    set = true;
                  }

                  if (context.mounted) {
                    if (set) {
                      prefs.setBool(Constants.boolKey, true);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataPage(),
                        ),
                      );
                    } else {
                      if (ScaffoldMessenger.of(context).mounted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: const Text(
                              "Please enter any one of the value first."),
                        ),
                      );
                    }
                  }
                },
                child: const Text("Save Data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
