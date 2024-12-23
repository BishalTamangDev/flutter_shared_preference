import 'package:flutter/material.dart';
import 'package:shared_pref_git/constants/constants.dart';
import 'package:shared_pref_git/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  // variables
  bool? boolValue;
  int? intValue;
  double? doubleValue;
  String? stringValue;
  List<String> stringListValue = [];

  @override
  void initState() {
    setPreferenceValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            spacing: 16.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32.0),
              Text("${Constants.boolKey} :: ${boolValue ?? 'null'}"),
              Text("${Constants.intKey} :: ${intValue ?? 'null'}"),
              Text("${Constants.doubleKey} :: ${doubleValue ?? 'null'}"),
              Text("${Constants.stringKey} :: ${stringValue ?? 'null'}"),
              Text(
                  "${Constants.stringListKey} :: ${stringListValue ?? 'null'}"),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  prefs.remove(Constants.boolKey);
                  prefs.remove(Constants.intKey);
                  prefs.remove(Constants.doubleKey);
                  prefs.remove(Constants.stringKey);
                  prefs.remove(Constants.stringListKey);

                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  }
                },
                child: const Text("RESET"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setPreferenceValues() async {
    var prefs = await SharedPreferences.getInstance();

    setState(() {
      boolValue = prefs.getBool(Constants.boolKey);
      intValue = prefs.getInt(Constants.intKey);
      doubleValue = prefs.getDouble(Constants.doubleKey);
      stringValue = prefs.getString(Constants.stringKey);
      stringListValue = prefs.getStringList(Constants.stringListKey) ?? [];
    });
  }
}
