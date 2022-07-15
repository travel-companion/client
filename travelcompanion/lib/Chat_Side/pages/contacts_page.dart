import 'package:flutter/material.dart';
import '../../map_side/main_map.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircuitMap(),
    );
  }
}
