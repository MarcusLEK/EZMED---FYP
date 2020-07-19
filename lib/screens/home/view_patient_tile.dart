import 'package:ezmed/screens/home/view_patient_details.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/models/patient.dart';

class ViewPatientTile extends StatelessWidget {
  
  final Patient patient;
  ViewPatientTile({ this.patient });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Icon(
            Icons.account_circle,
            color: Colors.green,
            size: 50,
          ),
          title: Text(patient.name),
          subtitle: Text(patient.ic),
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ViewPatientDetails(newPatient: patient))
            );
          }
        ),
      ),
    );
  }
}