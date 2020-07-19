import 'package:flutter/material.dart';
import 'package:ezmed/models/appointment.dart';
import 'package:ezmed/screens/home/view_appointment_tile.dart';
import 'package:provider/provider.dart';

class ViewAppoinmentList extends StatefulWidget {
  @override
  _ViewAppoinmentListState createState() => _ViewAppoinmentListState();
}

class _ViewAppoinmentListState extends State<ViewAppoinmentList> {
  @override
  Widget build(BuildContext context) {

    final appointments = Provider.of<List<Appointment>>(context) ?? [];

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return ViewAppointmentTile(appointment: appointments[index]);
      },
    );
  }
}