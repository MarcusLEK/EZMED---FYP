import 'package:ezmed/models/appointment.dart';
import 'package:ezmed/models/patient.dart';
import 'package:ezmed/screens/authenticate/new_appointment.dart';
import 'package:ezmed/screens/authenticate/new_patient_appointment.dart';
import 'package:ezmed/screens/home/view_appointment_list.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/shared/loading.dart';

class ViewPatientAppointment extends StatefulWidget {

  final String docID;
  ViewPatientAppointment({ this.docID });

  @override
  _ViewPatientAppointmentState createState() => _ViewPatientAppointmentState(patientID: docID);
}

class _ViewPatientAppointmentState extends State<ViewPatientAppointment> {

  final String patientID;
  _ViewPatientAppointmentState({ this.patientID });
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
    return StreamProvider<List<Appointment>>.value(
      value: DatabaseService().patientappointment(ic),
      child: loading ? Loading() : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Patient Appointments'),
          backgroundColor: Colors.blue,
          elevation: 0.0,
        ),
        body: ViewAppoinmentList(),
        floatingActionButton: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => NewPatientAppointment(uuid: patientID, patient: _newPatient))
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