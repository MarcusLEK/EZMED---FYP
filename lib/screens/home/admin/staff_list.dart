import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/models/staff.dart';
import 'package:ezmed/screens/home/admin/staff_tile.dart';


class StaffList extends StatefulWidget {
  @override
  _StaffListState createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  @override
  Widget build(BuildContext context) {

    final staffs = Provider.of<List<Staff>>(context) ?? [];

    return ListView.builder(
      itemCount: staffs.length,
      itemBuilder: (context, index) {
        return StaffTile(staff: staffs[index]);
      },
    );
  }
}