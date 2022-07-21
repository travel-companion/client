import 'package:flutter/material.dart';
import '../../map_side/main_map.dart';

class ContactsPage extends StatelessWidget {
    final roomNameDesu;
  const ContactsPage({Key? key,this.roomNameDesu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircuitMap(roomNameDesu:roomNameDesu),
    );
  }
}
