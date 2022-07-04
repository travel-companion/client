import 'package:flutter/material.dart';
import 'package:travelcompanion/screensfeed/Feed/feed/feed.dart';

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
  ClickMe() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FeedPublication()));
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          ClickMe();
        },
        child: Icon(
          Icons.live_help,
          size: 40,
          color: Color.fromARGB(255, 10, 10, 10),
        ),
      ),
    );
  }
}
