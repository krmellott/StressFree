import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/controller/stressFree_Controller.dart';
import 'package:firstapp/model/StressFreeModel.dart';
import 'package:flutter/material.dart';

class PastActivities extends StatefulWidget {
  @override
  _PastActivities createState() => _PastActivities();
}

class _PastActivities extends State<PastActivities> {
  final modelReference = new StressFreeModel();
  final controller = new StressFreeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Completed Activities'),
        ),
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.lightBlueAccent, Colors.white])),
                child: StreamBuilder(
                    stream: modelReference.dbRetrieveActivities(),
                    //FirebaseFirestore.instance.collection('activity').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Text('No completed activities.',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                            textScaleFactor: 1.25);

                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data?.docs[index]['status'] == true) {
                              final title = snapshot.data?.docs[index]['title'];
                              final date = snapshot.data?.docs[index]['date'];
                              final priority =
                                  snapshot.data?.docs[index]['priority'];

                              return Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Card(
                                    margin: EdgeInsets.fromLTRB(
                                        20.0, 6.0, 20.0, 0.0),
                                    child: ListTile(
                                        title: Text(title),
                                        subtitle: Text('Due date: ' +
                                            date.toString() +
                                            '\nPriority: ' +
                                            priority.toString()),
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: 300,
                                                color: Colors.lightBlueAccent,
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(title,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .white)),
                                                      Text(
                                                          'Due date: ' +
                                                              date.toString() +
                                                              '\nPriority: ' +
                                                              priority
                                                                  .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .white)),
                                                      ElevatedButton(
                                                          child: const Text(
                                                              'Mark as Incomplete'),
                                                          onPressed: () {
                                                            controller
                                                                .updateActivityCompletion(
                                                                    title,
                                                                    false);
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                      ElevatedButton(
                                                          child: const Text(
                                                              'Delete Activity'),
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .redAccent)),
                                                          onPressed: () {
                                                            controller
                                                                .deleteActivity(
                                                                    title);
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                  ));
                            }
                            return SizedBox(width: 0, height: 0);
                          });
                    }))));
  }
}
