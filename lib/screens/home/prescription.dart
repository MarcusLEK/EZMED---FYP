import 'package:ezmed/models/precriptiondetails.dart';
import 'package:ezmed/screens/authenticate/new_prescription.dart';
import 'package:ezmed/screens/home/prescription_list.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Prescription extends StatefulWidget {

  final String docID;
  Prescription({ this.docID });

  @override
  _PrescriptionState createState() => _PrescriptionState(doctoruid: docID);
}

class _PrescriptionState extends State<Prescription> {

  final String doctoruid;
  _PrescriptionState({ this.doctoruid });

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PrescriptionDetails>>.value(
      value: DatabaseService().prescriptions,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0.0,
          title: Text('Prescription'),
        ),
        body: PrescriptionList(),
        floatingActionButton: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => NewPrescription(uuid: doctoruid))
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}

