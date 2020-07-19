import 'package:ezmed/models/patient.dart';
import 'package:ezmed/screens/home/patient/prescriptions/patient_prescription_list.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/shared/loading.dart';
import 'package:ezmed/models/precriptiondetails.dart';

class PatientPrescription extends StatefulWidget {

  final String docID;
  PatientPrescription({ this.docID });

  @override
  _PatientPrescriptionState createState() => _PatientPrescriptionState(patientID: docID);
}

class _PatientPrescriptionState extends State<PatientPrescription> {

  final String patientID;
  _PatientPrescriptionState({ this.patientID });
  Patient _newPatient;
  bool loading = true;
  
  String ic = '';

  @override
  void initState() {
    run();
  }

  void run() async {
    dynamic patient = await DatabaseService().patientDetails(patientID);
    _newPatient = patient;
    ic = _newPatient.ic;
    setState(() => loading = false);
    if (patient == null) {
      print('null');
    } else {
      // print(_newPatient.name);
      // print(_newPatient.ic);
      // print(_newPatient.contact);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PrescriptionDetails>>.value(
      value: DatabaseService().patientprescriptions(ic),
      child: loading ? Loading() : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Prescription'),
          backgroundColor: Colors.blue,
          elevation: 0.0,
        ),
        body: PatientPrescriptionList(),
      ),
    );
  }
}