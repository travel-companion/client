import 'package:flutter/material.dart';
import 'package:travelcompanion/ScreensLoginsignup/register/register.dart';
import 'package:travelcompanion/componenetsloginsignup/background.dart';
import 'package:travelcompanion/commonloginSignup/theme_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../userProfil/userProfil.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ClickMe() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserProfil()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "LOGIN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 246, 240, 176),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),

            SizedBox(height: size.height * 0.1),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              color: const Color.fromARGB(255, 246, 240, 176),
              child: const TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  fillColor: Colors.amber,
                ),
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              color: const Color.fromARGB(255, 246, 240, 176),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: const TextField(
                decoration: InputDecoration(
                    labelText: "Password",
                    iconColor: Color.fromARGB(255, 235, 226, 131)),
                obscureText: true,
              ),
            ),

            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: const Text(
                "Forgot your password?",
                style: TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 234, 235, 192)),
              ),
            ),

            SizedBox(height: size.height * 0.05),

            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  ClickMe();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 235, 226, 131),
                        Colors.amber,
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "LOGIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()))
                },
                child: const Text(
                  "Don't Have an Account? Sign up",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 222, 225, 165)),
                ),
              ),
            ),

            ///Social media icons
            const SizedBox(height: 30.0),
            const Text(
              "Or login with social media",
              style: TextStyle(color: Color.fromARGB(255, 234, 225, 188)),
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    child: FaIcon(
                      FontAwesomeIcons.googlePlus,
                      size: 60,
                      color: HexColor("#EC2D2F"),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ThemeHelper().alartDialog("Google Plus",
                              "You can sign up with Google Plus.", context);
                        },
                      );
                    }),
                const SizedBox(
                  width: 30.0,
                ),
                const SizedBox(
                  width: 40.0,
                ),
                GestureDetector(
                  child: FaIcon(
                    FontAwesomeIcons.facebook,
                    size: 60,
                    color: HexColor("#3E529C"),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ThemeHelper().alartDialog("Facebook",
                            "You can sign up with facebook.", context);
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
