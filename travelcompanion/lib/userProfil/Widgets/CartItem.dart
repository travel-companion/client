import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travelcompanion/Chat_Side/main_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../userProfil.dart';

class CartItem extends StatefulWidget {
  final roomName;
  final userId;
  const CartItem({
    Key? key,
    required this.roomName,
    required this.userId,
  }) : super(key: key);
  @override
  cardItem createState() => cardItem();
}

class cardItem extends State<CartItem> {
  _pressed() {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Chat(
                    roomNameDesu: widget.roomName,
                  )));
    });
  }

  _delete(name) async {
    DocumentReference _userLines =
        FirebaseFirestore.instance.collection('UserData').doc(widget.userId);
    DocumentReference chatRoomData =
        FirebaseFirestore.instance.collection('chatRoomData').doc(widget.roomName);
    await chatRoomData.get().then((value) => {
      chatRoomData.update({"activeUsers":value["activeUsers"].where((e){
        return e?['uid']!=widget.userId;
      }).toList()})
    });
    await _userLines.get().then((value) => {
          _userLines.update({
            "userLines": value['userLines'].where((i) => i != name).toList()
          }).then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserProfil())))
        });
  }

  @override
  Widget build(BuildContext context) {
    var name = widget.roomName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    _pressed();
                  },
                  icon: FutureBuilder(
                  future: FirebaseFirestore.instance
                    .collection("chatRoomData")
                    .doc(widget.roomName)
                    .get(),
                      builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                         if (snapshot.hasError) {
                    return const Icon(
                          Icons.question_answer_sharp,
                          size: 33,
                          color: Color.fromARGB(255, 175, 140, 36),
                        );
                  }

                
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data?.data() as Map<String, dynamic>;
                    return (data["alert"]=="NO INCIDENT")?
                      const Icon(
                          Icons.question_answer_sharp,
                          size: 33,
                          color: Color.fromARGB(255, 175, 140, 36),
                        ):const Icon(
                          Icons.question_answer_sharp,
                          size: 33,
                          color: Colors.red,
                        );
                  }
                  return const Icon(
                          Icons.question_answer_sharp,
                          size: 33,
                          color: Color.fromARGB(255, 175, 140, 36),
                        );
                      }),
                ),
                const SizedBox(width: 15.0),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      const Text(
                        "Circuit Barcelone => La Marsa",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ]),
                IconButton(
                  padding: EdgeInsets.only(left: 30.0),
                  onPressed: () {
                    _delete(name);
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 33,
                    color: Color.fromARGB(255, 201, 18, 18),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
