import 'package:ezmed/screens/authenticate/patient_details.dart';
import 'package:ezmed/screens/authenticate/reset_pw.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/models/patient.dart';
import 'package:ezmed/shared/loading.dart';

class Profile extends StatefulWidget {

  final String docID;
  Profile({ this.docID });

  @override
  _ProfileState createState() => _ProfileState(patientID: docID);

}

class _ProfileState extends State<Profile> {

  final String patientID;
  _ProfileState({ this.patientID });
  Patient _newPatient;
  bool loading = true;

  @override
  void initState() {
    run();
  }

  void run() async {
    dynamic patient = await DatabaseService().patientDetails(patientID);
    _newPatient = patient;
    setState(() => loading = false);
    if (patient == null) {
      print('null');
    } else {
      // print(_newPatient.name);
      // print(_newPatient.ic);
      // print(_newPatient.contact);
    }
  }    

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Container(
                child: Card(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  borderOnForeground: false,
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.green,
                      size: 50,
                    ),
                    title: Text(_newPatient.name),
                    subtitle: Text(_newPatient.ic),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PatientDetails(patient: _newPatient, id: patientID))
                      );
                    },
                  ),
                ),                
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Update Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPW())
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}