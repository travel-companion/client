import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../comment.dart';

class Post extends StatefulWidget {
  @override
  cardItem createState() => new cardItem();
}


// class cardItem extends State<Post> {
//   _pressed() {
//     setState(() {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Comment()));
//     });
//   }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          color: Color.fromARGB(255, 47, 46, 43),
          height: 150.0,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://cdn.cp.adobe.io/content/2/rendition/3fde8129-0eb4-43ad-935e-e6139497e0c9/artwork/5bd7f793-4446-4337-826f-b869f3a3178b/version/0/format/jpg/dimension/width/size/300'),
                ),
                title: Text(
                  "Alex.M",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  "i y a 2 jours",
                  style: TextStyle(
                    color: Color.fromARGB(255, 118, 113, 113),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                    "where is the bus eli thez men carrefour marsa l ariana ???????????????????? yekhi ta7et panne plzz help",
                    style:
                        TextStyle(color: Color.fromARGB(255, 232, 232, 184))),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        _pressed();
                      },
                      icon: Icon(
                        Icons.comment,
                        color: Color.fromARGB(255, 232, 232, 184),
                      )),
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
}
