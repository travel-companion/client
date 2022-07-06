import 'package:flutter/material.dart';
import 'package:travelcompanion/screensLoginsignup/register/register.dart';

import 'aboutUs.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoToregister() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegisterScreen()));
    });
  }

  GotoAboutUs() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => aboutUs()));
    });
  }

  @override
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
              child: RaisedButton(
                onPressed: () {
                  GoToregister();
                },
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  'Register page',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: RaisedButton(
                onPressed: () {
                  GotoAboutUs();
                },
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  'About  us',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
