import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main_chat.dart';

class ReportPage extends StatefulWidget {
  final roomNameDesu;
  const ReportPage({Key? key, this.roomNameDesu}) : super(key: key);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<String> tests = ['Late', 'Broke down', 'Full'];
  String? selectedTest = 'Late';
  DocumentReference chatRoomData =
      FirebaseFirestore.instance.collection("chatRoomData").doc();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 90),
                child: SizedBox(
                  width: 400,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 224, 185, 78)))),
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
              ),
              Container(
                padding: const EdgeInsets.only(top: 160.0, right: 50.0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minHeight: 100,
                  ),
                  icon: const Icon(
                    Icons.bus_alert,
                    color: Colors.red,
                    size: 80,
                  ),
                  onPressed: () {
                    log(widget.roomNameDesu);
                    FirebaseFirestore.instance
                        .collection("chatRoomData")
                        .doc(widget.roomNameDesu)
                        .update({'alert': selectedTest}).then((value) => {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Chat(
                                              roomNameDesu: widget.roomNameDesu,
                                            )));
                              }),
                            });
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
