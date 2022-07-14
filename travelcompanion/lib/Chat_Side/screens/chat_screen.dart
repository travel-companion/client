import 'dart:developer';

import 'package:travelcompanion/userProfil/userProfil.dart';

import '../pages/calls_page.dart';
import '../pages/contacts_page.dart';
import '../pages/messages_page.dart';
import '../pages/report_page.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHome extends StatelessWidget {
  final roomNameDesu;
  String? _name;
  String? _photoUrl;
  ChatHome({required this.roomNameDesu, Key? key}) : super(key: key);
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  late ValueNotifier<String> title = ValueNotifier(roomNameDesu);

  late var pageTitles = [roomNameDesu, 'Report Incident', 'Calls', 'Map'];

  loggedUser() async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(user.uid)
        .get()
        .then((value) {
      _name = value.data()!['name'];
      _photoUrl = value.data()!['photoUrl'];
    });
    log(_photoUrl.toString());
  }

  void _onNavigationItemSelected(i) {
    title.value = pageTitles[i];
    pageIndex.value = i;
  }

  @override
  Widget build(BuildContext context) {
    loggedUser();
    final pages = [
      MessagesPage(
        roomNameDesu: roomNameDesu,
      ),
      ReportPage(),
      const CallsPage(),
      const ContactsPage(),
    ];
    return FutureBuilder(
      future: loggedUser(),
      builder: (context, snapshot) {
        child:
        return Scaffold(
          appBar: AppBar(
              //Top part 'title'
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: ValueListenableBuilder(
                valueListenable: title,
                builder: (BuildContext context, String value, _) {
                  return Text(
                    value,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 234, 193, 113)),
                  );
                },
              ),
              leadingWidth: 55,
              leading: Align(
                alignment: Alignment.centerRight,
                child: BackButton(
                  onPressed: () {
                    log('value$roomNameDesu');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UserProfil();
                        },
                      ),
                    );
                  },
                ),
                // child: IconBackground(
                //     icon: Icons.search,
                //     onTap: () {
                //       print('SEARCH');
                //     }),
              ),
              actions: [
                //Own avatar icon
                Padding(
                    padding: const EdgeInsets.only(right: 26.0),
                    child: Avatar.small(url: _photoUrl))
              ]),
          body: ValueListenableBuilder(
            valueListenable: pageIndex,
            builder: (BuildContext context, int value, _) {
              return pages[value];
            },
          ),
          bottomNavigationBar: _BottomNavigationBar(
            onItemselected: _onNavigationItemSelected,
          ),
        );
      },
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemselected,
  }) : super(key: key);

  final ValueChanged<int> onItemselected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemselected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: SafeArea(
          top: false,
          bottom: false,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _NavigationBarItem(
              onTap: handleItemSelected,
              index: 0,
              lable: 'Messages',
              icon: CupertinoIcons.bubble_left_bubble_right_fill,
              isSelected: (selectedIndex == 0),
            ),
            _NavigationBarItem(
              onTap: handleItemSelected,
              index: 1,
              lable: 'Report Incident',
              icon: CupertinoIcons.exclamationmark_circle_fill,
              isSelected: (selectedIndex == 1),
            ),
            _NavigationBarItem(
              onTap: handleItemSelected,
              index: 2,
              lable: 'Calls',
              icon: CupertinoIcons.phone_fill,
              isSelected: (selectedIndex == 2),
            ),
            _NavigationBarItem(
              onTap: handleItemSelected,
              index: 3,
              lable: 'Map ',
              icon: CupertinoIcons.location,
              isSelected: (selectedIndex == 3),
            )
          ])),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.onTap,
    required this.index,
    required this.lable,
    required this.icon,
    required this.isSelected,
  }) : super(key: key);

  final ValueChanged<int> onTap;
  final int index;
  final String lable;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
          height: 65,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 1, top: 5, bottom: 1),
                  child: Icon(icon,
                      size: isSelected ? 23 : 20,
                      color: isSelected ? AppColors.accent : null)),
              const SizedBox(
                height: 8,
              ),
              Text(lable,
                  style: isSelected
                      ? const TextStyle(
                          fontSize: 16,
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold)
                      : const TextStyle(fontSize: 13)),
            ],
          )),
    );
  }
}
