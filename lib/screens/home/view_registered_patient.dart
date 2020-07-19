import 'package:ezmed/models/patient.dart';
import 'package:ezmed/screens/authenticate/staff_register_patient.dart';
import 'package:ezmed/screens/home/view_patient_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/services/database.dart';

class ViewRegisteredPatient extends StatefulWidget {
  @override
  _ViewRegisteredPatientState createState() => _ViewRegisteredPatientState();
}

class _ViewRegisteredPatientState extends State<ViewRegisteredPatient> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Patient>>.value(
      value: DatabaseService().patients,
        child: Scaffold(
          backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Registered Patients'),
        ),
        body: ViewPatientList(),
        // floatingActionButton: Padding(
        //   padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context, 
        //         MaterialPageRoute(builder: (context) => StaffRegisterPatient())
        //       );
        //     },
        //     child: Icon(Icons.add),
        //     backgroundColor: Colors.blue,
        //   ),
        // ),
      ),
    );
  }
}