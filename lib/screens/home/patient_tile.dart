import 'package:flutter/material.dart';
import 'package:ezmed/models/patient.dart';

class PatientTile extends StatelessWidget {
  
  final Patient patient;
  PatientTile({ this.patient });

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
            Navigator.pop(context, patient);
          }
        ),
      ),
    );
  }
}