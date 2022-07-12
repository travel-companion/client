import 'dart:io';
import 'package:flutter/material.dart';
import 'clipper.dart';
import 'top_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

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
                          return const Text("Loading data...Please wait");
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
                          return const Text("Loading data...Please wait");
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
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80,
          backgroundColor: const Color(0xff476cfb),
          child: ClipOval(
              child: SizedBox(
            width: 180.0,
            height: 180.0,
            child: (_imageFile != null)
                ? Image.file(
                    _imageFile!,
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    "https://i0.wp.com/fac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2FFAC.2Fvar.2Ffemmeactuelle.2Fstorage.2Fimages.2Fanimaux.2Fveterinaire-les-conseils.2Fles-races-de-chats-de-a-a-z.2F3647789-16-fre-FR.2Fles-races-de-chats-de-a-a-z.2Ejpg/1200x1200/quality/80/crop-from/center/les-races-de-chats-de-a-a-z.jpeg",
                    // _photoUrl.toString(),
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
        SizedBox(width: 30),
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
    var image = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(image!.path);
    });
  }

  Future getImageCamera() async {
    var image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(image!.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = Path.basename(_imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask;
    _photoUrl = await (taskSnapshot).ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection("UserData/")
        .doc(_uid)
        .update({"photoUrl": _photoUrl});
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
      print(_email);
    }).catchError((e) {
      print(e);
    });
  }
}
