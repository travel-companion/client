import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travelcompanion/screensfeed/Feed/feed/feed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import 'Widgets/CartItem.dart';
import 'Widgets/clipper.dart';
import 'Widgets/stack_container.dart';
import 'Widgets/top_bar.dart';
class UserProfil extends StatefulWidget {
  @override
  _UserProfilState createState() => _UserProfilState();
}

class _UserProfilState extends State<UserProfil> {
  String? _email;
  String? _name;
  String? _photoUrl;
  String? _id;
  ClickMe(_email,_name,_photoUrl,_id) {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FeedPublication(emailUser:_email,nameUser:_name,photoUrlUser:_photoUrl,idUser:_id)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(),
            ListView.builder(
              itemBuilder: (context, index) => CartItem(),
              shrinkWrap: true,
              itemCount: 7,
            ),
          ],
        ),
      ),
      floatingActionButton:FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text("Loading data...Please wait");
                    return FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          ClickMe(_email,_name,_photoUrl,_id);
        },
        child: Icon(
          Icons.live_help,
          size: 40,
          color: Color.fromARGB(255, 10, 10, 10),
        ),
      );
      })
    );
  }
  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        _email = ds.data()!['email'];
        _name = ds.data()!['name'];
        _photoUrl = ds.data()!['photoUrl'];
        _id = ds.id;
      }).catchError((e) {
        print(e);
      });
    }
  }
}
