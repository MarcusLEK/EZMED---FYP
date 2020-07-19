import 'package:ezmed/models/queue.dart';
import 'package:ezmed/screens/home/staff/queue/view_queue_details.dart';
import 'package:flutter/material.dart';

class ViewQueueTile extends StatelessWidget {

  final Queue queue;
  ViewQueueTile({ this.queue });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Icon(
            Icons.assignment,
            color: Colors.green,
            size: 50,
          ),
          title: Text(queue.patientName),
          subtitle: Text(queue.time.toString()),
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ViewQueueDetails(newQueue: queue))
            );
          }
        ),
      ),
    );
  }
}