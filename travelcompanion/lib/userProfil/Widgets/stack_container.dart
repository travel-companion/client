// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'clipper.dart';
import 'top_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:getwidget/getwidget.dart';

class StackContainer extends StatefulWidget {
  @override
  _StackContainerState createState() => _StackContainerState();
}

class _StackContainerState extends State<StackContainer> {
  final imagePicker = ImagePicker();
  File? _imageFile;

  String? _email;
  String? _name;
  String? _photoUrl;
  String? _uid;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            alignment: const Alignment(0, 1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  imageProfile(),
                  const SizedBox(height: 4.0),
                  FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const GFLoader(
                      type: GFLoaderType.android,
                      size:GFSize.MEDIUM,
                     );
                        }
                        return Text(
                          " $_name",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 232, 197, 90),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                  FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const GFLoader(
                      type: GFLoaderType.android,
                      size:GFSize.MEDIUM,
                     );
                        }
                        return Text(
                          " $_email",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 232, 197, 90),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          const TopBar(),
        ],
      ),
    );
  }

  Widget imageProfile() {
    // String newImg =
    //     'https://cdn.futura-sciences.com/buildsv6/images/mediumoriginal/a/c/b/acb08455e1_128818_60-ans-nasa-02.jpg';
    // pic() {
    //   if (_photoUrl == null) {
    //     newImg =
    //         'https://cdn.futura-sciences.com/buildsv6/images/mediumoriginal/a/c/b/acb08455e1_128818_60-ans-nasa-02.jpg';
    //   } else {
    //     String newImg = _photoUrl!;
    //   }
    // }
    log(_photoUrl.toString());
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80,
          backgroundColor: const Color(0xff476cfb),
          child: ClipOval(
              child: SizedBox(
            width: 180.0,
            height: 180.0,
            child: (_photoUrl != null)?
            Image.network(
                    _photoUrl.toString(),  
                    fit: BoxFit.fill,
                  )
                //  Image.file(
                //     _imageFile!,
                //     fit: BoxFit.fill,
                //   )
                : Image.network(
                    'https://image.shutterstock.com/image-vector/profile-placeholder-image-gray-silhouette-600w-1637863831.jpg',
                    fit: BoxFit.fill,
                  ),
          )),
        ),
        Positioned(
          bottom: 12.0,
          right: 5.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Color.fromARGB(255, 243, 198, 73),
              size: 32.0,
            ),
          ),
        ),
        const SizedBox(width: 30),
        Positioned(
          bottom: 12.0,
          left: 0,
          child: RaisedButton(
            onPressed: () {
              uploadImageToFirebase(context);
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                  color: Color.fromARGB(255, 6, 6, 6), fontSize: 15.0),

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
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                getImageCamera();
              },
              label: const Text("Camera"),
            ),
            FlatButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                getImageGallery();
              },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  Future getImageGallery() async {
     await imagePicker.getImage(source: ImageSource.gallery).then((value){
      setState(() {
      _imageFile = File(value!.path);
    });
     });
    
  }

  Future getImageCamera() async {
    await imagePicker.getImage(source: ImageSource.camera).then((value){
    setState(() {
      _imageFile = File(value!.path);
    });
    });
    
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = Path.basename(_imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
     await uploadTask.then((value) async{
      _photoUrl = await (value).ref.getDownloadURL();
          await FirebaseFirestore.instance
        .collection("UserData/")
        .doc(_uid)
        .update({"photoUrl": _photoUrl}).then((value) => {
          setState(() {})
        });
    });
    
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(firebaseUser.uid)
        .get()
        .then((ds) {
      _email = ds.data()!['email'];
      _name = ds.data()!['name'];
      _uid = ds.data()!['uid'];
      _photoUrl=ds.data()!['photoUrl'];
    }).catchError((e) {
      print(e);
    });

  }
}
