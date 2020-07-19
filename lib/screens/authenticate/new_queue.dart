import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmed/models/patient.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/shared/constant.dart';
import 'package:ezmed/screens/home/registered_patient.dart';
import 'package:ezmed/shared/loading.dart';
import 'package:uuid/uuid.dart';

class NewQueue extends StatefulWidget {
  @override
  _NewQueueState createState() => _NewQueueState();
}

class _NewQueueState extends State<NewQueue> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller;
  TextEditingController _controller2;
  bool loading = false;
  Patient patient;
  var uuid = Uuid();

  void initState(){
    _controller = TextEditingController(text: ic);
    _controller2 = TextEditingController(text: name);
  }

  // variables to be stored
  String ic = '';
  String name = '';
  Timestamp timestamp = new Timestamp.now();
  int time;
  String uuid2; // queue document ID
  String patientID;

  void setTime() {
    time = timestamp.seconds;
  }

  @override
  Widget build(BuildContext context) {
    setTime();
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('New Queue'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
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
              SizedBox(height: 10),
              TextFormField(
                initialValue: time.toString(),
                textAlign: TextAlign.center,
                decoration: textInputDecoration,
                enabled: false,
              ),
              SizedBox(height: 20),
              Text(
                'Patient Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controller2,
                textAlign: TextAlign.center,
                enabled: false,
                validator: (val) => val.isEmpty ? 'Select Patient' : null,
                decoration: textInputDecoration,
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),
              SizedBox(height: 20),
              Text(
                'Patient ID',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _controller,
                textAlign: TextAlign.center,
                validator: (val) => val.isEmpty ? 'Select Patient' : null,
                decoration: textInputDecoration.copyWith(hintText: 'e.g. 9605XXXXXX'),
                onChanged: (val) {
                  setState(() => ic = val);
                },
                onTap: () async {
                  final Patient patient = await Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => RegisteredPatient())
                  );
                  setState(() => _controller.text = patient.ic);
                  setState(() => _controller2.text = patient.name);
                  setState(() => ic = patient.ic);
                  setState(() => name = patient.name);
                  setState(() => patientID = patient.docID);
                  print(patientID);
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red,
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      )
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'ADD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      )
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        uuid2 = uuid.v4();
                        setState(() => loading = true);
                        await DatabaseService().newQueue(uuid2, time, patientID, name);
                        await DatabaseService().setQueueID(uuid2, patientID);
                        setState(() => loading = false);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}