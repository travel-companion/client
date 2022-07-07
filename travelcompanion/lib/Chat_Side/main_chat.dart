import 'themes.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';

final appTheme = AppTheme();

class Chat extends StatelessWidget {
  final name;
  final roomNameDesu;
  const Chat({required this.roomNameDesu, this.name, Key? key})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme.light(),
      darkTheme: appTheme.dark(),
      themeMode: ThemeMode.dark,
      title: 'Chat',
      home: ChatHome(
        roomName: name,
        roomNameDesu: roomNameDesu,
      ),
    );
  }
}
