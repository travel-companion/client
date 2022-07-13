import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'circuitTime.dart';

class CircuitList extends StatefulWidget {
  const CircuitList({Key? key}) : super(key: key);

  @override
  State<CircuitList> createState() => _CircuitListState();
}

class _CircuitListState extends State<CircuitList> {
  // Line storage
  List<dynamic> lines = [];
  List<String> times = [];
  String searchString = "";

  //get lines
  Future getLineIDs() async {
    var tempLines = [];
    List<String> tempTimes = [];
    await FirebaseFirestore.instance.collection('lines').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              tempLines.add({
                'ref': document.data()['ref'],
                'times': document.data()['times']
              });
              for (var i = 0; i < document.data()['times'].length; i++) {
                tempTimes.add(document.data()['times'][i]['t']);
              }
            },
          ),
        );
    lines = tempLines;
    times = tempTimes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 187, 39),
        title: const Text(
          "Circuit List",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (String value) {
                setState(() {
                  searchString = value;
                });
              },
              decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  labelStyle: TextStyle(color: Colors.yellow),
                  prefixIcon: Icon(Icons.search),
                  focusColor: Colors.yellow,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          // IconButton(
          //     onPressed: getLineIDs,
          //     icon: const Icon(
          //       Icons.refresh,
          //       color: Colors.yellow,
          //     )),
          Expanded(
            child: FutureBuilder(
              future: getLineIDs(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: lines.length,
                    itemBuilder: (context, index) {
                      return lines[index]['ref']
                              .toString()
                              .toLowerCase()
                              .contains(searchString)
                          ? Card(
                              color: const Color.fromARGB(255, 255, 197, 37),
                              shadowColor:
                                  const Color.fromARGB(255, 255, 149, 0),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 153, 0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return CircuitTime(
                                                value: lines[index]);
                                          }));
                                        },
                                        icon: const Icon(
                                          Icons.arrow_upward,
                                          color:
                                              Color.fromARGB(255, 255, 230, 0),
                                        ))),
                                title: Text(
                                  lines[index]["ref"],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: const Icon(Icons.train),
                              ),
                            )
                          : Container();
                    });
              },
            ),
            // shrinkWrap: true,
            // scrollDirection: Axis.vertical,
            // reverse: true,
            // children: [
            //   Column(
            //     children: const [
            //       StreamBuilder<List<Circuit>>(
            //         stream: readCircuits(),
            //         builder: (context, snapshot) {
            //           if (snapshot.hasError) {
            //             return Text(
            //                 'Something went wrong! ${snapshot.error}');
            //           } else if (snapshot.hasData) {
            //             final circuits = snapshot.data!;

            //             return ListView(
            //               shrinkWrap: true,
            //               scrollDirection: Axis.vertical,
            //               children: circuits.map(buildCircuit).toList(),
            //             );
            //           } else {
            //             return const Center(
            //                 child: CircularProgressIndicator());
            //           }
            //         },
            //       )
            //     ],
            //   ),
            //   IconButton(
            //     onPressed: getLineIDs,
            //     icon: const Icon(
            //       Icons.refresh,
            //       color: Colors.yellow,
            //     ),
            //   ),
            // ],
          ),
        ]),
      ),
    );
  }

  // Stream<List<Circuit>> readCircuits() => FirebaseFirestore.instance
  SingleChildScrollView singleChildScroll() {
    return SingleChildScrollView(
      child: Column(
        children: [
          myCard(),
          myCard(),
          myCard(),
          myCard(),
          myCard(),
          myCard(),
          myCard(),
          myCard(),
          myCard(),
          myCard(),
          myCard(),
        ],
      ),
    );
  }

  Column myCard() {
    return Column(
      children: [
        Card(
          color: const Color.fromARGB(255, 255, 197, 37),
          shadowColor: const Color.fromARGB(255, 255, 149, 0),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const ListTile(
            leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 255, 153, 0),
                child: Icon(
                  Icons.arrow_upward,
                  color: Color.fromARGB(255, 255, 187, 0),
                )),
            title: Text("Circuit"),
            subtitle: Text("Circuit"),
            trailing: Icon(Icons.train),
          ),
        ),
        const Divider(
          color: Color.fromARGB(255, 255, 123, 0),
          thickness: 1,
          height: 10,
          indent: 20,
          endIndent: 20,
        )
      ],
    );
  }
}
