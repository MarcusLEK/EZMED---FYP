import 'package:flutter/material.dart';
import 'package:ezmed/models/staff.dart';

class StaffTile extends StatelessWidget {

  final Staff staff;
  StaffTile({ this.staff });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Icon(
            Icons.account_circle,
            color: Colors.green,
            size: 50,
          ),
          title: Text(staff.name),
          subtitle: Text(staff.contact),
        ),
      ),
    );
  }
}