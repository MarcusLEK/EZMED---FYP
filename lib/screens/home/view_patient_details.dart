import 'package:ezmed/screens/home/patient/appointments/view_patient_appointment.dart';
import 'package:ezmed/screens/home/patient/prescriptions/patient_prescription.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/models/patient.dart';

class ViewPatientDetails extends StatefulWidget {

  final Patient newPatient;
  ViewPatientDetails({ this.newPatient });

  @override
  _ViewPatientDetailsState createState() => _ViewPatientDetailsState(patient: newPatient);
}

class _ViewPatientDetailsState extends State<ViewPatientDetails> {

  final Patient patient;
  _ViewPatientDetailsState({ this.patient });

  String name;
  String contact;
  String ic;
  String patientDocID;

  void setData() {
    name = patient.name;
    contact = patient.contact;
    ic = patient.ic;
    patientDocID = patient.docID;
  }

  @override
  void initState() {
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Column(
            children: <Widget>[
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
                'Patient IC:',
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
                'Patient Contact:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$contact',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'View Prescriptions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => PatientPrescription(docID: patientDocID))
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'View Appointments',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => ViewPatientAppointment(docID: patientDocID))
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}