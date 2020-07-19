import 'package:flutter/material.dart';
import 'package:ezmed/models/queue.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/screens/home/staff/queue/view_queue_tile.dart';

class ViewQueueList extends StatefulWidget {
  @override
  _ViewQueueListState createState() => _ViewQueueListState();
}

class _ViewQueueListState extends State<ViewQueueList> {
  @override
  Widget build(BuildContext context) {

    final queues = Provider.of<List<Queue>>(context) ?? [];

    return ListView.builder(
      itemCount: queues.length,
      itemBuilder: (context, index) {
        return ViewQueueTile(queue: queues[index]);
      },
    );
  }
}