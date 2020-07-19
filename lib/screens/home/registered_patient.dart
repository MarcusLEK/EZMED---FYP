import 'package:ezmed/models/patient.dart';
import 'package:ezmed/screens/home/patient_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/services/database.dart';

class RegisteredPatient extends StatefulWidget {
  @override
  _RegisteredPatientState createState() => _RegisteredPatientState();
}

class _RegisteredPatientState extends State<RegisteredPatient> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Patient>>.value(
      value: DatabaseService().patients,
        child: Scaffold(
          backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Registered Patients'),
        ),
        body: PatientList(),
      ),
    );
  }
}