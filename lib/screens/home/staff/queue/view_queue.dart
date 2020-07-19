import 'package:ezmed/models/queue.dart';
import 'package:ezmed/screens/authenticate/new_queue.dart';
import 'package:ezmed/screens/home/staff/queue/view_queue_list.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/services/database.dart';
import 'package:provider/provider.dart';

class ViewQueue extends StatefulWidget {
  @override
  _ViewQueueState createState() => _ViewQueueState();
}

class _ViewQueueState extends State<ViewQueue> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Queue>>.value(
      value: DatabaseService().queues,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Queue'),
          backgroundColor: Colors.blue,
          elevation: 0.0,
        ),
        body: ViewQueueList(),
        floatingActionButton: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => NewQueue())
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}