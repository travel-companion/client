import 'dart:io';

import 'package:flutter/material.dart';
import 'clipper.dart';
import 'top_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

class StackContainer extends StatefulWidget {
  @override
  _StackContainerState createState() => _StackContainerState();
}

class _StackContainerState extends State<StackContainer> {
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  String? _email;
  String? _name;
  String? _photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Stack(
        children: <Widget>[
          Container(),
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 190,
              color: Colors.amber,
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  imageProfile(),
                  SizedBox(height: 4.0),
                  FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text("Loading data...Please wait");
                        return Text(
                          " $_name",
                          style: TextStyle(
                              color: Color.fromARGB(255, 232, 197, 90),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                  FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text("Loading data...Please wait");
                        return Text(
                          " $_email",
                          style: TextStyle(
                              color: Color.fromARGB(255, 232, 197, 90),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
          TopBar(),
        ],
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile != null
              ? FileImage(File(_imageFile!.path)) as ImageProvider
              : AssetImage("assets/R.png"),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.amber,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }


  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
     if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        setState(() {
      _imageFile = pickedFile;
    });
    }
    
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        _email = ds.data()!['email'];
        _name = ds.data()!['name'];
        _photoUrl = ds.data()!['photoUrl'];
        print(_email);
      }).catchError((e) {
        print(e);
      });
    }
  }
}
