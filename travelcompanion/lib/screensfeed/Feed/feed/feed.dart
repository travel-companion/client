import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

import '../../../userProfil/userProfil.dart';
import 'cartItem.dart';

class FeedPublication extends StatefulWidget {
  final dynamic emailUser;
  final dynamic nameUser;
  final dynamic photoUrlUser;
  final dynamic idUser;
  const FeedPublication(
      {Key? key, this.emailUser, this.nameUser, this.photoUrlUser, this.idUser})
      : super(key: key);
  @override
  _FeedPublicationState createState() => _FeedPublicationState();
}

class _FeedPublicationState extends State<FeedPublication> {
  final Stream<QuerySnapshot> post1 =
      FirebaseFirestore.instance.collection('posts').snapshots();
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  ClickMe() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserProfil()));
    });
  }

  @override
  Widget build(BuildContext context) {
    log(widget.photoUrlUser.toString());
    CollectionReference posts = FirebaseFirestore.instance.collection("posts");
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber,
              title: Text(
                'Travel Companion',
                style: TextStyle(
                  fontFamily: 'Boinkn',
                  fontStyle: FontStyle.italic,
                  foreground: Paint()
                  
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Colors.white,
                  // fontFamily: 'GrandHotel',
                  fontSize: 25,
                  letterSpacing: 1,
                ),
              ),
              actions: [
                IconButton(
                  padding: EdgeInsets.only(right: 30.0),
                  onPressed: () {
                    ClickMe();
                  },
                  icon: const Icon(Icons.home_filled, size: 50),
                ),
                const SizedBox(width: 10),
              ],
            ),
            body: Container(
              child: CommentBox(
                userImage:
                    widget.photoUrlUser, // ignore: sort_child_properties_last
                child: StreamBuilder<QuerySnapshot>(
                  stream: post1,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text("error");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("waiting");
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: ((context, index) => CardItemTest(
                          data.docs[index]['time'],
                          data.docs[index]['content'],
                          data.docs[index]['user'],
                          data.docs[index]['comments'],
                          data.docs[index]['pic'],
                          data.docs[index].id,
                          widget.emailUser,
                          widget.nameUser,
                          widget.photoUrlUser,
                          widget.idUser)),
                    );
                  },
                ),
                labelText: 'Ask for help or a circuit...',
                errorText: 'Comment cannot be blank',
                sendButtonMethod: () {
                  if (formKey.currentState!.validate()) {
                    log(widget.idUser.toString());
                    setState(() {
                      var value = {
                        'idUser': widget.idUser,
                        'user': widget.nameUser,
                        'pic': widget.photoUrlUser,
                        'content': commentController.text,
                        'comments': [],
                        'time': DateTime.now()
                      };
                      posts.add(value);
                    });
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  } else {
                    print("Not validated");
                  }
                },
                withBorder: false,
                formKey: formKey,
                commentController: commentController,
                backgroundColor: const Color.fromARGB(255, 12, 12, 12),
                textColor: Colors.white,
                sendWidget:
                    const Icon(Icons.send_sharp, size: 30, color: Colors.white),
              ),
            ),
          ),
        ));

    ///Social media icons
  }
}
