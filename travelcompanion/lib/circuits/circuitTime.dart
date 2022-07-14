import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Chat_Side/main_chat.dart';

class CircuitTime extends StatefulWidget {
  final value;
  const CircuitTime({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  State<CircuitTime> createState() => _CircuitTimeState();
}

class _CircuitTimeState extends State<CircuitTime> {
  // time storage
  List<String> times = [];
  String? _email;
  String? _name;
  String? _photoUrl;
  String? _uid;

  //get time
  Future getTimes() async {
    await FirebaseFirestore.instance.collection('lines').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              // print(document.data()['times']);
              for (var i = 0; i < document.data()['times'].length; i++) {
                times.add(document.data()['times'][i]['t']);
              }
            },
          ),
        );
  }

  loggedUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(firebaseUser.uid)
        .get()
        .then((ds) {
      _email = ds.data()!['email'];
      _name = ds.data()!['name'];
      _photoUrl = ds.data()!['photoUrl'];
      _uid = ds.data()!['uid'];
      print(_uid);
    }).catchError((e) {
      print(e);
    });
  }

  Future logCircuit() async {
    await FirebaseFirestore.instance
        .collection('UserData')
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element.data()[_name]);
            }));
  }

  Future addCircuit(room) async {
    await FirebaseFirestore.instance.collection('UserData').doc(_uid).update(({
          'userLines': FieldValue.arrayUnion([room])
        }));

    // .get()
    // .then((value) => value.data()?['userLines'].arrayUnion([room]));
  }

  Future addChat(room) async {
    await FirebaseFirestore.instance
        .collection('chatRoomData')
        .doc(room)
        .update(({
          'activeUsers': FieldValue.arrayUnion([
            {'name': _name, 'photoUrl': _photoUrl, 'uid': _uid}
          ])
        }));
  }

  @override
  Widget build(BuildContext context) {
    var value = widget.value;
    var times = log('value:$value');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 187, 39),
        title: const Text(
          "Circuit Times",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(children: <Widget>[
          // IconButton(
          //     onPressed: getLineIDs,
          //     icon: const Icon(
          //       Icons.refresh,
          //       color: Colors.yellow,
          //     )),
          Expanded(
            child: FutureBuilder(
              future: loggedUser(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: widget.value["times"].length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: const Color.fromARGB(255, 255, 197, 37),
                        shadowColor: const Color.fromARGB(255, 255, 149, 0),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 153, 0),
                            child: IconButton(
                              onPressed: (() {
                                String chatRoom =
                                    value['ref'] + value['times'][index]['t'];
                                var roomNameDesu = value['ref'];
                                log('test:$chatRoom');
                                addCircuit(chatRoom);
                                loggedUser();
                                addChat(chatRoom);

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Chat(
                                    roomNameDesu: chatRoom,
                                  );
                                }));
                              }),
                              icon: const Icon(
                                Icons.arrow_upward,
                                color: Color.fromARGB(255, 255, 230, 0),
                              ),
                            ),
                          ),
                          title: Text(
                            widget.value['times'][index]['t'],
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: const Icon(Icons.train),
                        ),
                      );
                    });
              },
            ),
          ),
        ]),
      ),
    );
  }
}
