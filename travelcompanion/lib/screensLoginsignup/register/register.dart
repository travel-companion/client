import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelcompanion/main.dart';
import 'package:travelcompanion/screensLoginsignup/login/login.dart';
import 'package:travelcompanion/componenetsloginsignup/background.dart';
import 'package:travelcompanion/commonloginSignup/theme_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../homeScreen/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  TextEditingController userNameController = TextEditingController();
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
            resizeToAvoidBottomInset: false,

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
              child: TextField(
                controller: userNameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
            ),

            SizedBox(height: size.height * 0.03),
            Container(
              color: const Color.fromARGB(255, 246, 240, 176),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "E-mail"),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              color: const Color.fromARGB(255, 246, 240, 176),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value) {
                    FirebaseFirestore.instance
                        .collection('UserData')
                        .doc(value.user?.uid)
                        .set({
                      "email": value.user?.email,
                      "uid": value.user?.uid,
                      "name": userNameController.text,
                      "role": "user",
                      "state": "Neutral",
                      "photoUrl":
                          "https://th.bing.com/th/id/R.73ec5d1d582914ba22315054b2167f46?rik=q8MGhMJPkooKPQ&riu=http%3a%2f%2fgetwallpapers.com%2fwallpaper%2ffull%2f6%2f0%2f3%2f265638.jpg&ehk=EG%2bNhzgIKJ34GwRfoCCogS77Rs4MBnFy9QqM7l0PGMw%3d&risl=&pid=ImgRaw&r=0",
                    });
                    print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                },
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
                      // signInWithGoogle();
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
// Future<UserCredential> signInWithGoogle() async {
//   final GoogleSignInAccount googleuser = await GoogleSignIn().signIn();

//   final GoogleSignInAuthentication googleAuth = await googleuser.authentication;

//   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//       idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
//   Fluttertoast.showToast(msg: "Account created");
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
