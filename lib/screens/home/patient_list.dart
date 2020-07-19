import 'package:ezmed/screens/home/patient_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/models/patient.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  @override
  Widget build(BuildContext context) {

    final patients = Provider.of<List<Patient>>(context) ?? [];

    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        return PatientTile(patient: patients[index]);
      },
    );
  }
}