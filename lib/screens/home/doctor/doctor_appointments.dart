import 'package:ezmed/models/appointment.dart';
import 'package:ezmed/screens/authenticate/new_appointment.dart';
import 'package:ezmed/screens/home/view_appointment_list.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorAppointment extends StatefulWidget {

  final String docID;
  DoctorAppointment({ this.docID });

  @override
  _DoctorAppointmentState createState() => _DoctorAppointmentState(doctoruid: docID);
}

class _DoctorAppointmentState extends State<DoctorAppointment> {

  final String doctoruid;
  _DoctorAppointmentState({ this.doctoruid });

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Appointment>>.value(
      value: DatabaseService().appointments,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Appointments'),
          backgroundColor: Colors.blue,
          elevation: 0.0,
        ),
        body: ViewAppoinmentList(),
      ),
    );
  }
}