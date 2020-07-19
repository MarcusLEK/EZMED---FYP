import 'package:ezmed/models/precriptiondetails.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/shared/loading.dart';

class PatientViewPrescription extends StatefulWidget {

  final PrescriptionDetails prescription;
  PatientViewPrescription({ this.prescription });

  @override
  _PatientViewPrescriptionState createState() => _PatientViewPrescriptionState(prescriptiondetail: prescription);
}

class _PatientViewPrescriptionState extends State<PatientViewPrescription> {
  
  void run(){
    uuid = prescriptiondetail.uuid;
    date = prescriptiondetail.date;
    ic = prescriptiondetail.ic;
    illness = prescriptiondetail.illness;
    medication = prescriptiondetail.medication;
    important = prescriptiondetail.important;
    name = prescriptiondetail.patientname;
    doctorname = prescriptiondetail.doctorname;
  }

  final PrescriptionDetails prescriptiondetail;
  _PatientViewPrescriptionState({ this.prescriptiondetail });

  bool loading = false;
  bool delete = false;

  String uuid;
  String date;
  String ic;
  String illness;
  String medication;
  String important;
  String name;
  String doctorname;

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Prescription'),
          content: Text(
            'Are you sure? \nThis action cannot undo.',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: 50,
            ),
            FlatButton(
              color: Colors.red,
              child: Text(
                'CONFIRM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
              onPressed: () {
                setState(() => delete = true);
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  void check(bool del) {
    if (del == true) {
      setState(() => loading = true);
      DatabaseService().deletePrescription(uuid);
      setState(() => loading = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    run();
    check(delete);
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Prescription Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                'Prescribed By:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'Dr. $doctorname',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Date:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$date',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Text(
                'PatientID:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$ic',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Patient Name:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$name',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Illness:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$illness',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Medication:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$medication',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Important:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$important',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}