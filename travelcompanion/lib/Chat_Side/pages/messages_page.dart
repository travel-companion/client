import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../dummy.dart';
import '../themes.dart';
import '../widgets/avatar.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
              child:Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(
                    Icons.question_answer_sharp,
                    size: 33,
                    color: Color.fromARGB(255, 175, 140, 36),
                  ),
                ),
                const SizedBox(width: 15.0),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "name",
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
    ),
            ),
            const SliverToBoxAdapter(
              child: _Stories(), //AKA member list of the specific circuit
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
                  log(data.size.toString());
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
            return const Text("waiting");
          }
          final data = snapshot.requireData;
          // dynamic chatRoom;
          // for (var i = 0; i < data.size; i++) {
          //   if (data.docs[i].id == widget.roomNameDesu) {
          //     chatRoom = data.docs[i].data();
          //     size = chatRoom['messages'].length;
          //   }
          // }
          log(index.toString());
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
  const _Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  itemBuilder: (BuildContext context, int index) {
                    //Get data from: Map on UserData then check UserLines and if TOP LINE NAME included in UserLines array, then add user in a list here to map on and show.
                    final faker = Faker();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 67,
                        child: _StoryCard(
                          storyData: StoryData(
                            name: faker.person.name(),
                            url: Helpers.randomPictureUrl(),
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
