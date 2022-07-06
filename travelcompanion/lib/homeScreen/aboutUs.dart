import 'package:flutter/material.dart';
import 'package:travelcompanion/screensLoginsignup/register/register.dart';

class aboutUs extends StatelessWidget {
  const aboutUs({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 35, 35),
      body: Container(
        padding: EdgeInsets.only(bottom: 180),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text('Travel Compagnion ',
                  style: TextStyle(
                      fontSize: 40, color: Color.fromARGB(255, 233, 200, 80))),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Text(
                'As the name suggests, these apps are developed for public transportation to facilitate life for the user and provide a real time chat rooms to be always up-to-date......)',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
