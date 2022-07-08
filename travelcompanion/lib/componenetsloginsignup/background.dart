import 'package:flutter/material.dart';

class Background1 extends StatelessWidget {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Background(
          child: this.child,
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 6,
            right: 6,
            child: Image.asset("assets/main.png", width: size.width * 0.18),
          ),
          Positioned(
            bottom: 0.03,
            child: Image.asset("assets/bottom.png",
                width: size.width * 0.7, height: size.height * 0.12),
          ),
          child
        ],
      ),
    );
  }
}
