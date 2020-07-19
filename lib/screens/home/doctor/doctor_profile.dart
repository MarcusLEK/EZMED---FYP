import 'package:ezmed/screens/authenticate/doctor_details.dart';
import 'package:ezmed/screens/authenticate/reset_pw.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/models/doctor.dart';
import 'package:ezmed/shared/loading.dart';

class DoctorProfile extends StatefulWidget {

  final String docID;
  DoctorProfile({ this.docID });

  @override
  _DoctorProfileState createState() => _DoctorProfileState(doctorID: docID);

}

class _DoctorProfileState extends State<DoctorProfile> {

  final String doctorID;
  _DoctorProfileState({ this.doctorID });
  Doctor _newDoctor;
  bool loading = true;

  @override
  void initState() {
    run();
  }

  void run() async {
    dynamic doctor = await DatabaseService().doctorDetails(doctorID);
    _newDoctor = doctor;
    setState(() => loading = false);
    if (doctor == null) {
      print('null');
    } else {
      
    }
  }    

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Doctor Profile'),
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
                    title: Text(_newDoctor.name),
                    subtitle: Text(_newDoctor.contact),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DoctorDetails(doctor: _newDoctor, id: doctorID))
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