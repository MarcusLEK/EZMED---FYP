import 'package:flutter/material.dart';
import 'package:ezmed/models/precriptiondetails.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/screens/home/prescription_tile.dart';

class PrescriptionList extends StatefulWidget {
  @override
  _PrescriptionListState createState() => _PrescriptionListState();
}

class _PrescriptionListState extends State<PrescriptionList> {
  @override
  Widget build(BuildContext context) {
    
    final precriptionDetails = Provider.of<List<PrescriptionDetails>>(context) ?? [];

    return ListView.builder(
      itemCount: precriptionDetails.length,
      itemBuilder: (context, index) {
        return PrescriptionTile(prescriptionDetail: precriptionDetails[index]);
      },
    );

  }
}