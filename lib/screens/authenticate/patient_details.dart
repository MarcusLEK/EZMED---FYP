import 'package:ezmed/models/patient.dart';
import 'package:ezmed/services/database.dart';
import 'package:ezmed/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/shared/loading.dart';

class PatientDetails extends StatefulWidget {
  
  final Patient patient;
  final String id;
  PatientDetails({ this.patient, this.id });
  
  @override
  _PatientDetailsState createState() => _PatientDetailsState(newPatient: patient, uuid: id);
}

class _PatientDetailsState extends State<PatientDetails> {
  
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  final Patient newPatient;
  final String uuid;
  _PatientDetailsState({ this.newPatient, this.uuid });

  String name = '';
  String contact = '';
  String ic;
  String error = '';

  @override
  void initState(){
    name = newPatient.name;
    contact = newPatient.contact;
    ic = newPatient.ic;
  }
  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Profile Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),       
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Icon(
                Icons.account_circle,
                color: Colors.blueGrey,
                size: 80,
              ),
              SizedBox(height: 20),
              Text(
                'IC/Passport No',
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                enabled: false,
                decoration: textInputDecoration.copyWith(hintText: ic),
              ),
              SizedBox(height: 20),
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: name,
                textAlign: TextAlign.center,
                validator: (val) => val.isEmpty ? 'Enter a name' : null,
                decoration: textInputDecoration.copyWith(hintText: 'e.g John Dou'),
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),
              SizedBox(height: 20),
              Text(
                'Contact',
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: contact,
                textAlign: TextAlign.center,
                validator: (val) => val.isEmpty ? 'Enter contact number' : null,
                decoration: textInputDecoration.copyWith(hintText: 'e.g. 019XXXXXXX'),
                onChanged: (val) {
                  setState(() => contact = val);
                },
              ),
              SizedBox(height: 20.0),
              Text(
                error, 
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.red,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await DatabaseService().updatePatientDetails(uuid, name, contact);
                          print(result);
                          setState(() {
                              error = 'Update Successful';
                              loading = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}