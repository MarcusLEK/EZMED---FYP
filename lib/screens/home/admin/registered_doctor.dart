import 'package:ezmed/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/services/database.dart';
import 'package:ezmed/screens/home/admin/doctor_list.dart';

class RegisteredDoctor extends StatefulWidget {
  @override
  _RegisteredDoctorState createState() => _RegisteredDoctorState();
}

class _RegisteredDoctorState extends State<RegisteredDoctor> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Doctor>>.value(
      value: DatabaseService().doctors,
        child: Scaffold(
          backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Registered Doctors'),
        ),
        body: DoctorList(),
      ),
    );
  }
}