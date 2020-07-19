import 'package:ezmed/models/queue.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';

class ViewQueueDetails extends StatefulWidget {

  final Queue newQueue;
  ViewQueueDetails({ this.newQueue });

  @override
  _ViewQueueDetailsState createState() => _ViewQueueDetailsState(queue: newQueue);
}

class _ViewQueueDetailsState extends State<ViewQueueDetails> {

  final Queue queue;
  _ViewQueueDetailsState({ this.queue });

  String patientID;
  String patientName;
  int time;
  String uuid;
  bool delete = false;

  void setData() {
    patientName = queue.patientName;
    patientID = queue.patientID;
    time = queue.time;
    uuid = queue.uuid;
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Queue'),
          content: Text(
            'Are you sure? \nThis action cannot undo.',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: 50,
            ),
            FlatButton(
              color: Colors.red,
              child: Text(
                'CONFIRM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
              onPressed: () {
                setState(() => delete = true);
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  void check(bool del) {
    if (del == true) {
      //print('appointment deleted');
      DatabaseService().deleteQueue(uuid);
      DatabaseService().deleteQueueID(patientID);
      //setState(() => delete = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    setData();
    check(delete);
    return Scaffold(
      appBar: AppBar(
        title: Text('Queue Details'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ), 
            onPressed: () {
              _showDialog();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Timestamp',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$time',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Patient Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$patientName',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}