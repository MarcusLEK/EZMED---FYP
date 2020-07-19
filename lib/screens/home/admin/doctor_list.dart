import 'package:ezmed/screens/home/admin/doctor_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/models/doctor.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {

    final doctors = Provider.of<List<Doctor>>(context) ?? [];

    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return DoctorTile(doctor: doctors[index]);
      },
    );

  }
}