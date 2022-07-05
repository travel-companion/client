import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:travelcompanion/componenetsloginsignup/background.dart';

import "package:travelcompanion/screensfeed/comment.dart";

import '../../../userProfil/userProfil.dart';
import 'cartItem.dart';

class FeedPublication extends StatefulWidget {
  @override
  _FeedPublicationState createState() => _FeedPublicationState();
}

class _FeedPublicationState extends State<FeedPublication> {
  ClickMe() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserProfil()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 240, 199, 78),
              title: Text(
                'Travel Companion',
                style: TextStyle(
                  fontFamily: 'GrandHotel',
                  fontSize: 34,
                  letterSpacing: 1,
                ),
              ),
              actions: [
                Icon(Icons.home_filled, size: 50),
                SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    ClickMe();
                  },
                  icon: Icon(Icons.person_pin_circle_outlined, size: 50),
                ),
                SizedBox(width: 10),
              ],
            ),
            body: Container(
              child: CommentBox(
                userImage:
                    "https://th.bing.com/th/id/R.b6114c06469c12bfbdd95dfd0ed78e47?rik=bGsyzd8rnPKMWg&pid=ImgRaw&r=0",
                // ignore: sort_child_properties_last
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: ((context, index) => Post()),
                ),
                labelText: 'Ask for help or a circuit...',
                errorText: 'Comment cannot be blank',

                withBorder: false,
                // formKey: formKey,
                // commentController: commentController,
                backgroundColor: Color.fromARGB(255, 12, 12, 12),
                textColor: Colors.white,
                sendWidget:
                    Icon(Icons.send_sharp, size: 30, color: Colors.white),
              ),
            ),
          ),
        ));

    ///Social media icons
  }
}
