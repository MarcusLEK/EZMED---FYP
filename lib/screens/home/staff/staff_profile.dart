import 'package:ezmed/models/staff.dart';
import 'package:ezmed/screens/authenticate/staff_details.dart';
import 'package:ezmed/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/services/database.dart';
import 'package:ezmed/screens/authenticate/reset_pw.dart';

class StaffProfile extends StatefulWidget {

  final String docID;
  StaffProfile({ this.docID });

  @override
  _StaffProfileState createState() => _StaffProfileState(staffID: docID);
}

class _StaffProfileState extends State<StaffProfile> {

  final String staffID;
  _StaffProfileState({ this.staffID });
  Staff _newStaff;
  bool loading = true;

  @override
  void initState() {
    run();
  }

  void run() async {
    dynamic staff = await DatabaseService().staffDetails(staffID);
    _newStaff = staff;
    setState(() => loading = false);
    if (staff == null) {
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
        title: Text('Staff Profile'),
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
                    title: Text(_newStaff.name),
                    subtitle: Text(_newStaff.contact),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StaffDetails(staff: _newStaff, id: staffID,))
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