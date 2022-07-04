import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelcompanion/Chat_Side/main_chat.dart';

class CartItem extends StatefulWidget {
  @override
  cardItem createState() => new cardItem();
}

class cardItem extends State<CartItem> {
  _pressed() {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Chat()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    _pressed();
                  },
                  icon: Icon(
                    Icons.question_answer_sharp,
                    size: 33,
                    color: Color.fromARGB(255, 175, 140, 36),
                  ),
                ),
                SizedBox(width: 15.0),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "ROOM 1",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        "Circuit Barcelone => La Marsa",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ])
              ]),
        ),
      ),
    );
  }
}
