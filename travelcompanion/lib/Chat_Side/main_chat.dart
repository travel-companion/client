import 'themes.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';

void main() {
  runApp(const Chat());
}

final appTheme = AppTheme();

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme.light(),
      darkTheme: appTheme.dark(),
      themeMode: ThemeMode.dark,
      title: 'Chat',
      home: HomeScreen(),
    );
  }
}
