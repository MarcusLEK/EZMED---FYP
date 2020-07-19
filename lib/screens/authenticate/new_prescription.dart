import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmed/models/doctor.dart';
import 'package:ezmed/models/precriptiondetails.dart';
import 'package:ezmed/screens/authenticate/confirm_prescription.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/shared/constant.dart';
import 'package:ezmed/screens/home/registered_patient.dart';
import 'package:ezmed/shared/loading.dart';
import 'package:ezmed/models/patient.dart';

class NewPrescription extends StatefulWidget {

  final String uuid;
  NewPrescription({ this.uuid });

  @override
  _NewPrescriptionState createState() => _NewPrescriptionState(useruid: uuid);
}

class _NewPrescriptionState extends State<NewPrescription> {

  final String useruid;
  _NewPrescriptionState({ this.useruid });

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller;
  TextEditingController _controller2;
  bool loading = false;
  Patient patient;
  Doctor _newDoctor;

  void initState(){
    _controller = TextEditingController(text: patientic);
    _controller2 = TextEditingController(text: name);
    run();
  }
  
  // variables for data
  String patientic = '';
  String illness = '';
  String meds = '';
  String important = '';
  DateTime date2 = new DateTime.now();
  String date;
  String error = '';
  String name = '';
  String prescribedby = '';
  Timestamp timeStamp = new Timestamp.now();
  int timestamp;

  void setTime() {
    timestamp = timeStamp.microsecondsSinceEpoch;
    print(timestamp);
  }

  void setDate() {
    date = date2.day.toString() + '/' + date2.month.toString() + '/' + date2.year.toString();
  }

  void run() async {
    dynamic doctor = await DatabaseService().doctorDetails(useruid);
    _newDoctor = doctor;
    setState(() => loading = false);
    if (doctor == null) {
      print('null');
    } else {
      
    }
  }  

  @override
  Widget build(BuildContext context) {
    setDate();
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('New Prescription'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Prescribed By',
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
                  setState(() => patientic = val);
                },
                onTap: () async {
                  final Patient patient = await Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => RegisteredPatient())
                  );
                  setState(() => _controller.text = patient.ic);
                  setState(() => _controller2.text = patient.name);
                  setState(() => patientic = patient.ic);
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
                'Illness/Symptoms',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLines: null, // infinite number of lines as you type
                validator: (val) => val.isEmpty ? 'Enter illness/symptoms' : null,
                decoration: textInputDecoration.copyWith(hintText: ' e.g. fever, cold'),
                onChanged: (val) {
                  setState(() => illness = val);
                }
              ),
              SizedBox(height: 20),
              Text(
                'Prescription',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLines: null, // infinite number of lines as you type
                validator: (val) => val.isEmpty ? 'Enter medication' : null,
                decoration: textInputDecoration.copyWith(hintText: 'e.g. paracetemol'),
                onChanged: (val) {
                  setState(() => meds = val);
                }
              ),
              SizedBox(height: 20),
              Text(
                'Important Notice',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text('(Optional)'),
              SizedBox(height: 10),
              TextFormField(
                maxLines: null, // infinite number of lines as you type
                decoration: textInputDecoration.copyWith(hintText: 'e.g. finish all dosage'),
                onChanged: (val) {
                  setState(() => important = val);
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error, 
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        await DatabaseService().createPrescription(timestamp, useruid, date, _newDoctor.name, patientic, illness, meds, important, name);
                        setState(() => loading = false);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}