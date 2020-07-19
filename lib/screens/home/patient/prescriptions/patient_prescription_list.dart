import 'package:flutter/material.dart';
import 'package:ezmed/models/precriptiondetails.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/screens/home/patient/prescriptions/patient_prescription_tile.dart';

class PatientPrescriptionList extends StatefulWidget {
  @override
  _PatientPrescriptionListState createState() => _PatientPrescriptionListState();
}

class _PatientPrescriptionListState extends State<PatientPrescriptionList> {
  @override
  Widget build(BuildContext context) {
    
    final precriptionDetails = Provider.of<List<PrescriptionDetails>>(context) ?? [];

    return ListView.builder(
      itemCount: precriptionDetails.length,
      itemBuilder: (context, index) {
        return PatientPrescriptionTile(prescriptionDetail: precriptionDetails[index]);
      },
    );

  }
}