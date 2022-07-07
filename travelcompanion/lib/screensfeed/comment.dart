import 'dart:developer';

import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../userProfil/userProfil.dart';

class Comment extends StatefulWidget {
  final dynamic c;
  final dynamic id;

  const Comment({Key? key, this.c, this.id}) : super(key: key);
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final Stream<QuerySnapshot> commentsStream =
      FirebaseFirestore.instance.collection('comments').snapshots();
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'Aziz',
      'pic':
          'https://th.bing.com/th/id/OIP.jAmsTDku4U8sc88PpNlwqwHaLH?pid=ImgDet&rs=1',
      'message': 'there are a greve lets take a taxi'
    },
    {
      'name': 'Imen',
      'pic':
          'https://th.bing.com/th/id/OIP.B8BaeERx9jBaFTVcaxb5TAHaEo?pid=ImgDet&rs=1',
      'message': 'you have an other solution take the collectif taxi'
    },
    {
      'name': 'Ahmed',
      'pic': 'https://picsum.photos/300/30',
      'message': 'there are a lockout today i hope you find a solution'
    },
    {
      'name': 'Ali',
      'pic':
          'https://th.bing.com/th/id/OIP.jAmsTDku4U8sc88PpNlwqwHaLH?pid=ImgDet&rs=1',
      'message': 'to morrow you have a public transport available'
    },
    {
      'name': 'Aziz',
      'pic':
          'https://th.bing.com/th/id/OIP.jAmsTDku4U8sc88PpNlwqwHaLH?pid=ImgDet&rs=1',
      'message': 'there are a greve lets take a taxi'
    },
    {
      'name': 'Imen',
      'pic':
          'https://th.bing.com/th/id/OIP.B8BaeERx9jBaFTVcaxb5TAHaEo?pid=ImgDet&rs=1',
      'message': 'you have an other solution take the collectif taxi'
    },
    {
      'name': 'Ahmed',
      'pic': 'https://picsum.photos/300/30',
      'message': 'there are a lockout today i hope you find a solution'
    },
    {
      'name': 'Aziz',
      'pic':
          'https://th.bing.com/th/id/OIP.jAmsTDku4U8sc88PpNlwqwHaLH?pid=ImgDet&rs=1',
      'message': 'there are a greve lets take a taxi'
    },
    {
      'name': 'Imen',
      'pic':
          'https://th.bing.com/th/id/OIP.B8BaeERx9jBaFTVcaxb5TAHaEo?pid=ImgDet&rs=1',
      'message': 'you have an other solution take the collectif taxi'
    },
    {
      'name': 'Ahmed',
      'pic': 'https://picsum.photos/300/30',
      'message': 'there are a lockout today i hope you find a solution'
    },
  ];

  Widget commentChild(data, line, user) {
    DocumentReference userinfo =
        FirebaseFirestore.instance.doc('UserData/$user');
    DocumentReference lineinfo =
        FirebaseFirestore.instance.collection("lines").doc(line);

    log("test:$lineinfo,user:$userinfo");
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
          child: FutureBuilder<DocumentSnapshot>(
            future: userinfo.get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return ListTile(
                  leading: GestureDetector(
                    onTap: () async {
                      // Display the image in large form.
                      print("Comment Clicked");
                    },
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: new BoxDecoration(
                          color: Color.fromARGB(255, 243, 233, 33),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(50))),
                      child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(data['photoUrl'])),
                    ),
                  ),
                  title: Text(
                    data["name"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: FutureBuilder<DocumentSnapshot>(
                    future: lineinfo.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Text("Document does not exist");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Text(" ${data['ref']}");
                      }

                      return Text("loading");
                    },
                  ),
                );
              }

              return Text("loading");
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    String postid = widget.id;
    DocumentReference post =
        FirebaseFirestore.instance.collection("posts").doc(postid);
    CollectionReference comments =
        FirebaseFirestore.instance.collection("comments");
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        child: CommentBox(
          userImage:
              "https://th.bing.com/th/id/R.b6114c06469c12bfbdd95dfd0ed78e47?rik=bGsyzd8rnPKMWg&pid=ImgRaw&r=0",
          child: StreamBuilder<QuerySnapshot>(
            stream: commentsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("waiting");
              }
              final t = snapshot.requireData.docs[0].id;
              final data = snapshot.requireData.docs
                  .where((i) => widget.c.contains(i.id))
                  .toList();
              final x = data;
              log('data:$data id:$x');
              return ListView.builder(
                itemCount: widget.c.length,
                itemBuilder: ((context, index) => commentChild(
                    filedata, data[index]['lines'], data[index]['user'])),
              );
            },
          ),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'lines': "gftfkn36f2fUsOm4nhu3",
                  'user': "y3DLWv5L9ThvAuGaT9OZtiiOFob2",
                };
                comments.add(value).then((value) =>
                 {
                  post.update({'comments': [...widget.c,value.id]})                
                 }
                 );
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Color.fromARGB(255, 14, 14, 14),
          textColor: Color.fromARGB(255, 212, 199, 199),
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.amber),
        ),
      ),
    );
  }
}
