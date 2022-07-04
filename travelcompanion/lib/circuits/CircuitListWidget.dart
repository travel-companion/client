// import 'package:flutter/material.dart';
// import 'circuitSchema.dart';

// class CircuitListTileWidget extends StatelessWidget {
//   final Circuit circuit;
//   final bool isSelected;
//   final ValueChanged<Circuit> onSelectedCircuit;

//   const CircuitListTileWidget({
//     key,
//     required this.circuit,
//     required this.isSelected,
//     required this.onSelectedCircuit,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final selectedColor = Theme.of(context).primaryColor;
//     final style = isSelected
//         ? TextStyle(
//             fontSize: 18,
//             color: selectedColor,
//             fontWeight: FontWeight.bold,
//           )
//         : const TextStyle(fontSize: 18);

//     return ListTile(
//         title: Text(
//           circuit.name,
//           style: style,
//         ),
//         trailing: isSelected
//             ? Icon(
//                 Icons.check,
//                 color: selectedColor,
//                 size: 26,
//               )
//             : null);
//   }
// }
