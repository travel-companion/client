import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CircuitTime extends StatefulWidget {
  final value;
  const CircuitTime({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  State<CircuitTime> createState() => _CircuitTimeState();
}

class _CircuitTimeState extends State<CircuitTime> {
  // time storage
  List<String> times = [];

  //get time
  Future getTimes() async {
    await FirebaseFirestore.instance.collection('lines').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              // print(document.data()['times']);
              for (var i = 0; i < document.data()['times'].length; i++) {
                times.add(document.data()['times'][i]['t']);
              }
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 187, 39),
        title: const Text(
          "Circuit Times",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(children: <Widget>[
          // IconButton(
          //     onPressed: getLineIDs,
          //     icon: const Icon(
          //       Icons.refresh,
          //       color: Colors.yellow,
          //     )),
          Expanded(
            child: FutureBuilder(
              future: getTimes(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: times.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: const Color.fromARGB(255, 255, 197, 37),
                        shadowColor: const Color.fromARGB(255, 255, 149, 0),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 255, 153, 0),
                              child: Icon(
                                Icons.arrow_upward,
                                color: Color.fromARGB(255, 255, 238, 0),
                              )),
                          title: Text(
                            times[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: const Icon(Icons.train),
                        ),
                      );
                    });
              },
            ),
          ),
        ]),
      ),
    );
  }
}
