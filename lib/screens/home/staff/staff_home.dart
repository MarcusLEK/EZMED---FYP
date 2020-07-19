import 'package:ezmed/screens/home/staff/appointments/view_appoinment.dart';
import 'package:ezmed/screens/home/staff/queue/view_queue.dart';
import 'package:ezmed/screens/home/view_registered_patient.dart';
import 'package:ezmed/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/screens/home/staff/staff_profile.dart';

class StaffHome extends StatelessWidget {

  final AuthService _auth = AuthService();
  final String uid;
  StaffHome({ this.uid });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('EZMED: Staff Home'),
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
                      'Patients',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => ViewRegisteredPatient())
                      );
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Appointments',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => ViewAppointment(docID: uid))
                      );
                    },
                  ),
                ),
                Container(
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Queue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => ViewQueue())
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
                        MaterialPageRoute(builder: (context) => StaffProfile(docID: uid))
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}