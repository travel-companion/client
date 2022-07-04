import 'package:flutter/material.dart';
import 'package:travelcompanion/screensLoginsignup/login/login.dart';
import 'package:travelcompanion/componenetsloginsignup/background.dart';
import 'package:travelcompanion/commonloginSignup/theme_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterScreen extends StatelessWidget {
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
                "REGISTER",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 246, 240, 176),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.1),
            Container(
              color: const Color.fromARGB(255, 246, 240, 176),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: const TextField(
                decoration: InputDecoration(labelText: "Name"),
              ),
            ),

            SizedBox(height: size.height * 0.03),
            Container(
              color: const Color.fromARGB(255, 246, 240, 176),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: const TextField(
                decoration: InputDecoration(labelText: "E-mail"),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              color: const Color.fromARGB(255, 246, 240, 176),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: const TextField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.black,
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
                    "SIGN UP",
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
                      MaterialPageRoute(builder: (context) => LoginScreen()))
                },
                child: const Text(
                  "Already Have an Account? Sign in",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 229, 231, 183)),
                ),
              ),
            ),

            ///Social media icons

            const Text(
              "Or create account using social media",
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
                              "You tap on GooglePlus social icon.", context);
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
            ),
          ],
        ),
      ),
    );
  }
}
