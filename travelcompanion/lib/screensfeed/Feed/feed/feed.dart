import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:travelcompanion/componenetsloginsignup/background.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';


import "package:travelcompanion/screensfeed/comment.dart";

import '../../../userProfil/userProfil.dart';
import 'cartItem.dart';



class FeedPublication extends StatefulWidget {
  @override
  _FeedPublicationState createState() => _FeedPublicationState();
}

class _FeedPublicationState extends State<FeedPublication> {

    final Stream<QuerySnapshot>post1=FirebaseFirestore.instance.collection('posts').snapshots();

      List post=[
     {
      'name': 'Aziz',
      'pic':
          'https://th.bing.com/th/id/OIP.jAmsTDku4U8sc88PpNlwqwHaLH?pid=ImgDet&rs=1',
      'content': 'there are a greve lets take a taxi',
      'time':DateFormat('dd-MMM-yyy').format(DateTime.fromMillisecondsSinceEpoch(1638592424384))
    },
    {
      'name': 'Imen',
      'pic':
          'https://th.bing.com/th/id/OIP.B8BaeERx9jBaFTVcaxb5TAHaEo?pid=ImgDet&rs=1',
      'content': 'you have an other solution take the collectif taxi',
      'time':DateFormat('dd-MMM-yyy').format(DateTime.fromMillisecondsSinceEpoch(1638592424384))
    },
    {
      'name': 'Ahmed',
      'pic': 'https://picsum.photos/300/30',
      'content': 'there are a lockout today i hope you find a solution',
      'time':DateFormat('dd-MMM-yyy').format(DateTime.fromMillisecondsSinceEpoch(1638592424384))
    },
    {
      'name': 'Ali',
      'pic':
          'https://th.bing.com/th/id/OIP.jAmsTDku4U8sc88PpNlwqwHaLH?pid=ImgDet&rs=1',
      'content': 'to morrow you have a public transport available',
      'time':DateFormat('dd-MMM-yyy').format(DateTime.fromMillisecondsSinceEpoch(1638592424384))
    },
    {
      'name': 'Aziz',
      'pic':
          'https://th.bing.com/th/id/OIP.jAmsTDku4U8sc88PpNlwqwHaLH?pid=ImgDet&rs=1',
      'content': 'there are a greve lets take a taxi',
      'time':DateFormat('dd-MMM-yyy').format(DateTime.fromMillisecondsSinceEpoch(1638592424384))
    },
    {
      'name': 'Imen',
      'pic':
          'https://th.bing.com/th/id/OIP.B8BaeERx9jBaFTVcaxb5TAHaEo?pid=ImgDet&rs=1',
      'content': 'you have an other solution take the collectif taxi',
      'time':DateFormat('dd-MMM-yyy').format(DateTime.fromMillisecondsSinceEpoch(1638592424384))
    },
    {
      'name': 'Ahmed',
      'pic': 'https://picsum.photos/300/30',
      'content': 'there are a lockout today i hope you find a solution',
      'time':DateFormat('dd-MMM-yyy').format(DateTime.fromMillisecondsSinceEpoch(1638592424384))
    },
    {
      'name': 'Aziz',
      'pic':
          'https://th.bing.com/th/id/OIP.jAmsTDku4U8sc88PpNlwqwHaLH?pid=ImgDet&rs=1',
      'content': 'there are a greve lets take a taxi',
      'time':DateFormat('dd-MMM-yyy').format(DateTime.fromMillisecondsSinceEpoch(1638592424384))
    },
    {
      'name': 'Imen',
      'pic':
          'https://th.bing.com/th/id/OIP.B8BaeERx9jBaFTVcaxb5TAHaEo?pid=ImgDet&rs=1',
      'content': 'you have an other solution take the collectif taxi',
      'time':DateFormat('dd-MMM-yyy').format(DateTime.fromMillisecondsSinceEpoch(1638592424384))
    },
    {
      'name': 'Ahmed',
      'pic': 'https://picsum.photos/300/30',
      'content': 'there are a lockout today i hope you find a solution',
      'time':DateFormat('dd-MMM-yyy').format(DateTime.fromMillisecondsSinceEpoch(1638592424384))
    },
  ];
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
                 child:StreamBuilder<QuerySnapshot>(
                  stream: post1,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("error");
                    }
                    if (snapshot.connectionState==ConnectionState.waiting) {
                      return Text("waiting");
                    }
                    final data=snapshot.requireData;
                    return
                      ListView.builder(
                       itemCount: data.size,
                       itemBuilder: ((context, index) => CardItemTest(post[index],data.docs[index]['content'],data.docs[index]['user'],data.docs[index]['comments'])),
                       );
                  },
                ),
                // child: ListView.builder(
                //   itemCount: post.length,
                //   itemBuilder: ((context, index) => CardItemTest(post[index])),
                // ),
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
