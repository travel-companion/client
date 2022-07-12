import 'package:flutter/material.dart';
import 'package:travelcompanion/Chat_Side/main_chat.dart';

class CartItem extends StatefulWidget {
  final roomName;
  const CartItem({
    Key? key,
    required this.roomName,
  }) : super(key: key);
  @override
  cardItem createState() => cardItem();
}

class cardItem extends State<CartItem> {
  _pressed() {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Chat(
                    name: widget.roomName,
                    roomNameDesu: widget.roomName,
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    var name = widget.roomName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
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
                  icon: const Icon(
                    Icons.question_answer_sharp,
                    size: 33,
                    color: Color.fromARGB(255, 175, 140, 36),
                  ),
                ),
                const SizedBox(width: 15.0),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      const Text(
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
