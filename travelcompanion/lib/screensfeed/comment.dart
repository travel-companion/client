import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'Feed/feed/feed.dart';
import '../userProfil/userProfil.dart';
import '../circuits/circuitTime.dart';
import 'package:getwidget/getwidget.dart';
import 'package:badges/badges.dart';

class Comment extends StatefulWidget {
  final dynamic c;
  final dynamic id;
  final dynamic emailUser;
  final dynamic nameUser;
  final dynamic photoUrlUser;
  final dynamic idUser;
  const Comment(
      {Key? key,
      this.c,
      this.id,
      this.emailUser,
      this.nameUser,
      this.photoUrlUser,
      this.idUser})
      : super(key: key);
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  List<dynamic> allLines = [];
  String searchString = "";
  List<dynamic> linesid = [];
  final controller = TextEditingController();
  final Stream<QuerySnapshot> commentsStream =
      FirebaseFirestore.instance.collection('comments').snapshots();
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  Widget commentChild(line, user) {
    DocumentReference userinfo =
        FirebaseFirestore.instance.doc('UserData/$user');
    DocumentReference lineinfo =
        FirebaseFirestore.instance.collection("lines").doc(line);
    CollectionReference linesInfo =
        FirebaseFirestore.instance.collection('lines');
    positiveReview() async {
      await userinfo.get().then((value) {
        var uData=value.data() as Map<String, dynamic>;
        log((uData["reviews"]!=null).toString());
        if (uData["reviews"]!=null) {
          if (!uData["reviews"]["ids"].contains(widget.idUser)) {
            userinfo.update({
              "reviews": {
                "ids": [...uData["reviews"]["ids"],widget.idUser],
                "count": uData["reviews"]["count"] + 1
              }
            });
          }
        } else {
          userinfo.update({
            "reviews": {
              "ids":[widget.idUser],
              "count": 1
            }
          });
        }
      });
    }

    negativeReview() async {
      await userinfo.get().then((value) {
        var uData=value.data() as Map<String, dynamic>;
        if (uData["reviews"]!=null) {
          if (!uData["reviews"]["ids"].contains(widget.idUser)) {
            userinfo.update({
              "reviews": {
                "ids": [...uData["reviews"]["ids"],widget.idUser],
                "count": uData["reviews"]["count"] - 1
              }
            });
          }
        } else {
          userinfo.update({
            "reviews": {
              "ids":[widget.idUser],
              "count": -1
            }
          });
        }
      });
    }
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
          child: Column(
            children: [
              FutureBuilder<DocumentSnapshot>(
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
                          await linesInfo.doc(line).get().then((value) => {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CircuitTime(value: value.data());
                                }))
                              });
                        },
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 243, 233, 33),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child:FutureBuilder<DocumentSnapshot>(
          future: userinfo.get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              if (data["reviews"] == null || data["reviews"]["count"] == 0) {
                return Badge(
                  badgeColor: Colors.grey,
                  child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(data['photoUrl'])
                              ),
                );
              }
              else if(data["reviews"]["count"] > 0){
                return Badge(
                  badgeColor: Colors.green,
                  child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(data['photoUrl'])
                              ),
                );
              }
              else{
                return Badge(
                  badgeColor: Colors.red,
                  child:CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(data['photoUrl'])
                              ),
                ); 
              }
            }

            return Text("loading");
          },
        ),
                          
                           
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

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                child: Container(
                  height: 15.0,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          positiveReview();
                        },
                        icon: Icon(
                          Icons.thumb_up,
                          color: Colors.green,
                          size: 20.0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          negativeReview();
                        },
                        icon: Icon(
                          Icons.thumb_down,
                          color: Colors.red,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    //  var  allLines = [];
    getLines() async {
      var temp = [];
      var ids = [];
      await FirebaseFirestore.instance
          .collection('lines')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          var data = doc.data();
          var id = doc.id;
          temp.add(data);
          ids.add(id);
        });
      });
      allLines = temp;
      linesid = ids;
    }

    final Stream<QuerySnapshot> linesStream =
        FirebaseFirestore.instance.collection('lines').snapshots();
    String postid = widget.id;
    DocumentReference post =
        FirebaseFirestore.instance.collection("posts").doc(postid);
    CollectionReference comments =
        FirebaseFirestore.instance.collection("comments");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.amber,
      ),
      body: Column(children: <Widget>[
        Container(
          height: 400,
          child: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: commentsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("error");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const GFLoader(
                    type: GFLoaderType.android,
                    size: GFSize.MEDIUM,
                  );
                }
                if (snapshot.requireData.docs.isEmpty) {
                  return Text("no comments");
                }
                final data = snapshot.requireData.docs
                    .where((i) => widget.c.contains(i.id))
                    .toList();
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) =>
                      commentChild(data[index]['lines'], data[index]['user'])),
                );
              },
            ),
          ),
        ),
        Container(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "search lines",
                contentPadding: const EdgeInsets.all(20.0),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 243, 233, 33))),
                suffixIcon: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.photoUrlUser),
                )),
            onChanged: (String value) {
              setState(() {
                searchString = value;
              });
            },
          ),
        ),
        Expanded(
            child: FutureBuilder(
          future: getLines(),
          builder: (context, snapshot) {
            if (allLines == null) {
              return Text("Document does not exist");
            } else {
              // return Text("data");
              return ListView.builder(
                itemCount: allLines.length,
                itemBuilder: ((context, index) {
                  return allLines[index]['ref']
                          .toString()
                          .toLowerCase()
                          .contains(searchString)
                      ? ListTile(
                          leading: Icon(Icons.train),
                          title: Text(allLines[index]['ref']),
                          onTap: () => {
                            comments.add({
                              'lines': linesid[index],
                              'user': widget.idUser,
                            }).then((value) => {
                                  post.update({
                                    'comments': [...widget.c, value.id]
                                  })
                                }),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FeedPublication(
                                        emailUser: widget.emailUser,
                                        nameUser: widget.nameUser,
                                        photoUrlUser: widget.photoUrlUser,
                                        idUser: widget.idUser))),
                          },
                        )
                      : Container();
                }),
              );
            }
          },
        ))
      ]),
    );
  }
}
