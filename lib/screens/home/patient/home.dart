import 'package:ezmed/screens/home/patient/prescriptions/patient_prescription.dart';
import 'package:ezmed/screens/home/patient/appointments/view_patient_appointment.dart';
import 'package:ezmed/screens/home/patient/remoteQueue/remote_queue.dart';
import 'package:ezmed/services/auth.dart';
import 'package:ezmed/screens/home/patient/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  final String uid;
  Home({ this.uid });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('EZMED: Patient'),
          backgroundColor: Colors.blue,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(30.0),
              sliver: SliverGrid.count(
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Appointment',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => ViewPatientAppointment(docID: uid))
                        );
                      },
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Prescription',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => PatientPrescription(docID: uid))
                        );
                      },
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Remote Queue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => RemoteQueue(docID: uid))
                        );
                      },
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => Profile(docID: uid))
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}