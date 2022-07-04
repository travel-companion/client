import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';

import '../userProfil/userProfil.dart';

class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'Aziz',
      'pic':
          'https://th.bing.com/th/id/OIP.jAmsTDku4U8sc88PpNlwqwHaLH?pid=ImgDet&rs=1',
      'message': 'there are a greve lets take a taxi'
    },
    {
      'name': 'Imen',
      'pic':
          'https://th.bing.com/th/id/OIP.B8BaeERx9jBaFTVcaxb5TAHaEo?pid=ImgDet&rs=1',
      'message': 'you have an other solution take the collectif taxi'
    },
    {
      'name': 'Ahmed',
      'pic': 'https://picsum.photos/300/30',
      'message': 'there are a lockout today i hope you find a solution'
    },
    {
      'name': 'Ali',
      'pic':
          'https://th.bing.com/th/id/OIP.jAmsTDku4U8sc88PpNlwqwHaLH?pid=ImgDet&rs=1',
      'message': 'to morrow you have a public transport available'
    },
    {
      'name': 'Aziz',
      'pic':
          'https://th.bing.com/th/id/OIP.jAmsTDku4U8sc88PpNlwqwHaLH?pid=ImgDet&rs=1',
      'message': 'there are a greve lets take a taxi'
    },
    {
      'name': 'Imen',
      'pic':
          'https://th.bing.com/th/id/OIP.B8BaeERx9jBaFTVcaxb5TAHaEo?pid=ImgDet&rs=1',
      'message': 'you have an other solution take the collectif taxi'
    },
    {
      'name': 'Ahmed',
      'pic': 'https://picsum.photos/300/30',
      'message': 'there are a lockout today i hope you find a solution'
    },
    {
      'name': 'Aziz',
      'pic':
          'https://th.bing.com/th/id/OIP.jAmsTDku4U8sc88PpNlwqwHaLH?pid=ImgDet&rs=1',
      'message': 'there are a greve lets take a taxi'
    },
    {
      'name': 'Imen',
      'pic':
          'https://th.bing.com/th/id/OIP.B8BaeERx9jBaFTVcaxb5TAHaEo?pid=ImgDet&rs=1',
      'message': 'you have an other solution take the collectif taxi'
    },
    {
      'name': 'Ahmed',
      'pic': 'https://picsum.photos/300/30',
      'message': 'there are a lockout today i hope you find a solution'
    },
  ];

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Color.fromARGB(255, 243, 233, 33),
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        child: CommentBox(
          userImage:
              "https://th.bing.com/th/id/R.b6114c06469c12bfbdd95dfd0ed78e47?rik=bGsyzd8rnPKMWg&pid=ImgRaw&r=0",
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': 'Jasmine',
                  'pic':
                      'https://th.bing.com/th/id/R.b6114c06469c12bfbdd95dfd0ed78e47?rik=bGsyzd8rnPKMWg&pid=ImgRaw&r=0',
                  'message': commentController.text
                };
                filedata.insert(0, value);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Color.fromARGB(255, 14, 14, 14),
          textColor: Color.fromARGB(255, 212, 199, 199),
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.amber),
        ),
      ),
    );
  }
}
