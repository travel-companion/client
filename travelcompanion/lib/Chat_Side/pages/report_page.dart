import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<String> tests = ['Test 1', 'Test 2', 'Test 3', 'Test 4'];
  String? selectedTest = 'Test 1';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
            child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 90),
          child: SizedBox(
            width: 400,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 1, color: Color.fromARGB(255, 224, 185, 78)))),
              value: selectedTest,
              items: tests
                  .map((test) => DropdownMenuItem<String>(
                        value: test,
                        child: Text(
                          test,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 180, 135, 12)),
                        ),
                      ))
                  .toList(),
              onChanged: (test) => setState(() => selectedTest = test),
            ),
          ),
        )),
      );
}
