import 'package:ezmed/models/queue.dart';
import 'package:ezmed/screens/home/staff/queue/view_queue_list.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/services/database.dart';
import 'package:provider/provider.dart';

class DoctorQueue extends StatefulWidget {
  @override
  _DoctorQueueState createState() => _DoctorQueueState();
}

class _DoctorQueueState extends State<DoctorQueue> {
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
      ),
    );
  }
}