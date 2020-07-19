import 'package:ezmed/models/appointment.dart';
import 'package:ezmed/screens/authenticate/new_appointment.dart';
import 'package:ezmed/screens/home/view_appointment_list.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAppointment extends StatefulWidget {

  final String docID;
  ViewAppointment({ this.docID });

  @override
  _ViewAppointmentState createState() => _ViewAppointmentState(staffuid: docID);
}

class _ViewAppointmentState extends State<ViewAppointment> {

  final String staffuid;
  _ViewAppointmentState({ this.staffuid });

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
        floatingActionButton: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => NewAppointment(uuid: staffuid))
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