import 'package:flutter/material.dart';

import 'clipper.dart';
import 'top_bar.dart';

class StackContainer extends StatelessWidget {
  const StackContainer({
    Key? key,
  }) : super(key: key);

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.F4yYROfAci7ReouU7k9CcAHaFI?pid=ImgDet&rs=1',
                  ),
                  radius: 80,
                ),
                SizedBox(height: 4.0),
                Text(
                  "Yasmine",
                  style: TextStyle(
                      color: Color.fromARGB(255, 217, 217, 178),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Jasmine.hs@gmail.com",
                  style: TextStyle(
                      color: Color.fromARGB(255, 217, 217, 178),
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          TopBar(),
        ],
      ),
    );
  }
}
