import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmed/models/patient.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/shared/constant.dart';
import 'package:ezmed/shared/loading.dart';
import 'package:uuid/uuid.dart';

class RemoteQueue extends StatefulWidget {

  final String docID;
  RemoteQueue({ this.docID });

  @override
  _RemoteQueueState createState() => _RemoteQueueState(patientID: docID);
}

class _RemoteQueueState extends State<RemoteQueue> {

  final String patientID;
  _RemoteQueueState({ this.patientID });
  Patient _newPatient;
  bool loading = true;
  var uuid = Uuid();

  String buttonName = 'QUEUE';
  bool change = false;
  Color color = Colors.blue;
  String msg = 'You are not in queue';

  String ic = '';
  String name = '';
  Timestamp timestamp;
  int time;
  String uid; // queue document ID

  @override
  void initState() {
    run();
  }

  void run() async {
    dynamic patient = await DatabaseService().patientDetails(patientID);
    _newPatient = patient;
    ic = _newPatient.ic;
    name = _newPatient.name;
    setState(() => loading = false);
    if (patient == null) {
      print('null');
    } else {
      // do nothing
      checkQueue(_newPatient.queueID);
    }
  }  

  void checkQueue(String queueID) {
    if(queueID != '') {
      setState(() {
        loading = true;
        buttonName = 'STOP QUEUE';
        change = true;
        color = Colors.red;
        msg = 'You are queued. \nPlease wait till you are called';
        uid = _newPatient.queueID;
      });
      setState(() => loading = false);
    }
  }

  void setTime() {
    timestamp = new Timestamp.now();
    time = timestamp.seconds;
  }

  @override
  Widget build(BuildContext context) {
    print(uid);
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('Remote Queue'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: color,
                child: Text(
                  buttonName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
                onPressed: () async {
                  if(change == false) {
                    setTime();
                    uid = uuid.v4();
                    setState(() {
                      loading = true;
                      buttonName = 'STOP QUEUE';
                      change = true;
                      color = Colors.red;
                      msg = 'You are queued. \nPlease wait till you are called';
                    });
                    await DatabaseService().newQueue(uid, time, ic, name);
                    await DatabaseService().setQueueID(uid, patientID);
                    setState(() => loading = false);
                  } else {
                    setState(() {
                      loading = true;
                      buttonName = 'QUEUE';
                      change = false;
                      color = Colors.blue;
                      msg = 'You are no longer in queue';
                    });
                    await DatabaseService().deleteQueue(uid);
                    await DatabaseService().deleteQueueID(patientID);
                    setState(() => loading = false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}