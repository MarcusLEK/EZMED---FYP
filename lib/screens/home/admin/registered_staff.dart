import 'package:ezmed/models/staff.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/services/database.dart';
import 'package:ezmed/screens/home/admin/staff_list.dart';

class RegisteredStaff extends StatefulWidget {
  @override
  _RegisteredStaffState createState() => _RegisteredStaffState();
}

class _RegisteredStaffState extends State<RegisteredStaff> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Staff>>.value(
      value: DatabaseService().staffs,
        child: Scaffold(
          backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Registered Staffs'),
        ),
        body: StaffList(),
      ),
    );
  }
}