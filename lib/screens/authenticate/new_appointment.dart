import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmed/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/shared/constant.dart';
import 'package:ezmed/shared/loading.dart';
import 'package:ezmed/screens/home/registered_patient.dart';
import 'package:ezmed/services/database.dart';
import 'package:ezmed/models/staff.dart';

class NewAppointment extends StatefulWidget {

  final String uuid;
  NewAppointment({ this.uuid });

  @override
  _NewAppointmentState createState() => _NewAppointmentState(useruid: uuid);
}

class _NewAppointmentState extends State<NewAppointment> {

  final String useruid;
  _NewAppointmentState({ this.useruid });

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller;
  TextEditingController _controller2;
  bool loading = false;
  Patient patient;

  void initState(){
    _controller = TextEditingController(text: ic);
    _controller2 = TextEditingController(text: name);
  }

  // variables to be stored
  String date = '';
  String time = '';
  String ic = '';
  String name = '';
  String status = 'booked';
  String note = '';
  String creatorname = '';
  Timestamp timeStamp = new Timestamp.now();
  int timestamp;

  void setTime() {
    print(timeStamp);
    timestamp = timeStamp.microsecondsSinceEpoch;
    print(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('New Appointment'),
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
                'Created By',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: useruid,
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
                },
              ),
              SizedBox(height: 20),
              Text(
                'Date',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                textAlign: TextAlign.center,
                initialValue: date,
                validator: (val) => val.isEmpty ? 'Enter date' : null,
                decoration: textInputDecoration.copyWith(hintText: 'e.g. 1-1-2020'),
                onChanged: (val) {
                  setState(() => date = val);
                },
              ),
              SizedBox(height: 20),
              Text(
                'Time',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                textAlign: TextAlign.center,
                initialValue: date,
                validator: (val) => val.isEmpty ? 'Enter time' : null,
                decoration: textInputDecoration.copyWith(hintText: 'e.g. 2.30 p.m'),
                onChanged: (val) {
                  setState(() => time = val);
                },
              ),
              SizedBox(height: 20),
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: textInputDecoration.copyWith(hintText: 'e.g. important notes...'),
                onChanged: (val) {
                  setState(() => note = val);
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
                      'SAVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      )
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setTime();
                        setState(() => loading = true);
                        await DatabaseService().createAppointment(timestamp, useruid, date, time, status, note, ic, name);
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