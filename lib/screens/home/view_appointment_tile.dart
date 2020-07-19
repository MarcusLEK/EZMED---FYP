import 'package:ezmed/screens/home/view_appointment_details.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/models/appointment.dart';

class ViewAppointmentTile extends StatelessWidget {

  final Appointment appointment;
  ViewAppointmentTile({ this.appointment });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Icon(
            Icons.assignment,
            color: Colors.green,
            size: 50,
          ),
          title: Text(appointment.date),
          subtitle: Text(appointment.time),
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ViewAppointmentDetails(newAppointment: appointment))
            );
          }
        ),
      ),
    );
  }
}