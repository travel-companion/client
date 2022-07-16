import 'dart:developer';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../themes.dart';
import '../widgets/avatar.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getwidget/getwidget.dart';

class MessagesPage extends StatefulWidget {
  final roomNameDesu;
  const MessagesPage({
    required this.roomNameDesu,
    Key? key,
  }) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  // final roomName = widget.roomNameDesu;
  // Stream<QuerySnapshot<dynamic>> chat =
  //     FirebaseFirestore.instance.collection(widget.roomNameDesu).snapshots();
  final controller = TextEditingController();
  String? _name;
  String? _photoUrl;
  String? _uid;

  String message = '';

  loggedUser() async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(user.uid)
        .get()
        .then((value) {
      _name = value.data()!['name'];
      _photoUrl = value.data()!['photoUrl'];
      _uid = value.data()!['uid'];
    });
  }

  var size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("chatRoomData")
                    .doc(widget.roomNameDesu)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    const GFLoader(
                      type: GFLoaderType.android,
                      size:GFSize.MEDIUM,
                     );

                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data?.data() as Map<String, dynamic>;

                    return data["alert"]!="NO INCIDENT"?
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 0.0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(width: 15.0),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Icon(Icons.bus_alert_rounded,
                                            color: Colors.red),
                                      ),
                                      const SizedBox(height: 1.0),
                                      Text(
                                        data["alert"],
                                        style: TextStyle(
                                          foreground: Paint()
                                            ..color = Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      )
                                    ]),
                              ]),
                        ),
                      ),
                    ):Text("");
                  }
                  return Text("");
                },
              ),

              //knkn
            ),
            SliverToBoxAdapter(
              child: _Stories(
                roomNameDesu: widget.roomNameDesu,
              ), //AKA member list of the specific circuit
            ),
            SliverToBoxAdapter(child: text(context)),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(widget.roomNameDesu)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("error");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SliverList(
                      delegate:
                          SliverChildBuilderDelegate(_delegate, childCount: 0),
                    );
                  }
                  final data = snapshot.requireData;
                  // log(data.size.toString());
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(_delegate,
                        childCount: data.size),
                  );
                }),
          ],
        ), //ndknsdk
      ),
    );
  }

  Widget text(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'Send message',
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async {
              await loggedUser();
              var val = {
                'content': message,
                'pic': _photoUrl,
                'time': DateTime.now(),
                'user': _name,
              };
              FirebaseFirestore.instance
                  .collection(widget.roomNameDesu)
                  .add(val);
              controller.clear();
            },
          ),
        ),
        onChanged: (String value) {
          setState(() {
            message = value;
          });
        });
  }

  Widget _delegate(BuildContext context, int index) {
    //This should be refactored to get from Firestore now
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(widget.roomNameDesu)
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const GFLoader();
          }
          final data = snapshot.requireData;
          return _MessageTitle(
            messageData: MessageData(
              senderName: data.docs[index]['user'],
              message: data.docs[index]['content'],
              messageDate: data.docs[index]['time'].toDate(),
              dateMessage: data.docs[index]['time'].toDate().toString(),
              profilePicture: data.docs[index]['pic'],
            ),
          );
        });
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 160,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: const BoxDecoration(
          border: Border(
            bottom:
                BorderSide(color: Color.fromARGB(255, 58, 57, 57), width: 0.7),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Avatar.medium(url: messageData.profilePicture),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      messageData.senderName,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 245, 187, 95),
                          overflow: TextOverflow.ellipsis,
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight: FontWeight.w900),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0.2, top: 3, bottom: 2),
                      child: Text(
                        messageData.message,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 242, 203, 110),
                            overflow: TextOverflow.clip,
                            letterSpacing: 0.1,
                            wordSpacing: 1,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      messageData.dateMessage.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 10,
                          color: Color.fromARGB(255, 201, 191, 105)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Stories extends StatelessWidget {
  final roomNameDesu;
  final membersList = [];
  _Stories({
    required this.roomNameDesu,
    Key? key,
  }) : super(key: key);

  getParticipants() async {
    await FirebaseFirestore.instance
        .collection('chatRoomData')
        .doc(roomNameDesu)
        .get()
        .then((value) {
      {
        print(value.data()?['activeUsers']);
        value.data()?['activeUsers'].forEach((val) {
          // log(val.toString());
          membersList.add(val);
          log(membersList[0]['photoUrl']);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getParticipants(),
        builder: (context, snapshot) {
          return Card(
            child: SizedBox(
              height: 134,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 6, bottom: 7),
                    child: Text(
                      //THIS SHOULD BE THE CIRCUIT NAME INSTEAD //Not really because circuit name is on top now
                      'Members',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: AppColors.textFaded),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: membersList.length,
                        itemBuilder: (BuildContext context, int index) {
                          //Get data from: Map on UserData then check UserLines and if TOP LINE NAME included in UserLines array, then add user in a list here to map on and show.
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 67,
                              child: _StoryCard(
                                storyData: StoryData(
                                  name: membersList[index]['name'],
                                  url: membersList[index]['photoUrl'],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class _StoryCard extends StatelessWidget {
  //Active people in chat
  const _StoryCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                letterSpacing: 0.4,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
