import 'package:ezmed/screens/home/view_prescription.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/models/precriptiondetails.dart';

class PrescriptionTile extends StatelessWidget {
  
  final PrescriptionDetails prescriptionDetail;
  PrescriptionTile({ this.prescriptionDetail });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(prescriptionDetail.patientname),
          subtitle: Text(prescriptionDetail.date),
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ViewPrescription(prescription: prescriptionDetail))
            );
          },
        ),
      ),
    );
  }
}