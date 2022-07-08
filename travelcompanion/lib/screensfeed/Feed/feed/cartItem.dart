import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../comment.dart';
import 'dart:developer';


DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

@override
Widget CardItemTest(
    dynamic time, dynamic content, dynamic user, List<dynamic> comments,dynamic pic) {
  log('user: $user / comments:$comments');
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
                time.toString(),
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
                button(c:comments),
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
  const button({
    this.c,
    Key? key,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    log('test pass $c');
    return IconButton(
        onPressed: ()=>{
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Comment()))         
        },
        icon: Icon(
          Icons.comment,
          color: Color.fromARGB(255, 232, 232, 184),
        ));
  }
}
// }
