import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../comment.dart';
import 'dart:developer';


@override
Widget CardItemTest(
    String time,
    dynamic content,
    dynamic user, 
    List<dynamic> comments,
    dynamic pic,
    String id,
    emailUser,
    nameUser,
    photoUrlUser,
    idUser
    
    ) {
  return Card(
    child: Container(
        color: Color.fromARGB(255, 47, 46, 43),
        height: 150.0,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(pic),
              ),
              title: Text(
                user,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                time,
                style: TextStyle(
                  color: Color.fromARGB(255, 118, 113, 113),
                ),
              ),
            ),
            Expanded(
              child: Text(content,
                  style: TextStyle(color: Color.fromARGB(255, 232, 232, 184))),
            ),
            Row(
              children: <Widget>[
                button(c:comments,id:id,emailUser:emailUser,nameUser:nameUser,photoUrlUser:photoUrlUser,idUser:idUser),
                SizedBox(width: 8.0),
                Text(
                  "comment",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        )),
  );
}

class button extends StatelessWidget {
      final dynamic c;
      final dynamic id;
      final dynamic emailUser;
      final dynamic nameUser;
      final dynamic  photoUrlUser;
      final dynamic idUser;
  const button({
    this.c,
    this.id,
    this.emailUser,
    this.nameUser,
    this.photoUrlUser,
    this.idUser,
    Key? key,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: ()=>{
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Comment(c:c,id:id,emailUser:emailUser,nameUser:nameUser,photoUrlUser:photoUrlUser,idUser:idUser)))         
        },
        icon: Icon(
          Icons.comment,
          color: Color.fromARGB(255, 232, 232, 184),
        ));
  }
}
// }
