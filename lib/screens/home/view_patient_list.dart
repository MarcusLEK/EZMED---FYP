import 'package:ezmed/screens/home/view_patient_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/models/patient.dart';

class ViewPatientList extends StatefulWidget {
  @override
  _ViewPatientListState createState() => _ViewPatientListState();
}

class _ViewPatientListState extends State<ViewPatientList> {
  @override
  Widget build(BuildContext context) {

    final patients = Provider.of<List<Patient>>(context) ?? [];

    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        return ViewPatientTile(patient: patients[index]);
      },
    );
  }
}