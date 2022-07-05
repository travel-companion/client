import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../comment.dart';
import 'dart:developer';

// class Post extends StatefulWidget {
//   final dynamic onePost;

//   const onePost ({ Key? key, this.onePost }): super(key: key);
//   @override
//   cardItem createState() => new cardItem();
// }

// class cardItem extends State<Post> {
//   _pressed() {
//     setState(() {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Comment()));
//     });
//   }

@override
Widget CardItemTest(
    dynamic data, dynamic content, dynamic user, List<dynamic> comments) {
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
                backgroundImage: NetworkImage(data['pic']),
              ),
              title: Text(
                data['name'],
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                data['time'],
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
