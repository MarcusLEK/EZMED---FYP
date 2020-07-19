import 'package:ezmed/models/precriptiondetails.dart';
import 'package:flutter/material.dart';

class ConfirmPrescription extends StatefulWidget {

  final PrescriptionDetails prescriptionDetails;
  ConfirmPrescription({ this.prescriptionDetails });

  @override
  _ConfirmPrescriptionState createState() => _ConfirmPrescriptionState(newPrescriptionDetails: prescriptionDetails);
}

class _ConfirmPrescriptionState extends State<ConfirmPrescription> {

  final PrescriptionDetails newPrescriptionDetails;
  _ConfirmPrescriptionState({ this.newPrescriptionDetails });

  String uuid;
  String date;
  String ic;
  String illness;
  String medication;
  String important;
  String name;
  String doctorname;

  void run(){
    uuid = newPrescriptionDetails.uuid;
    date = newPrescriptionDetails.date;
    ic = newPrescriptionDetails.ic;
    illness = newPrescriptionDetails.illness;
    medication = newPrescriptionDetails.medication;
    important = newPrescriptionDetails.important;
    name = newPrescriptionDetails.patientname;
    doctorname = newPrescriptionDetails.doctorname;
  }

  @override
  Widget build(BuildContext context) {
    run();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Confirm Prescription'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                'Prescribed By:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'Dr. $doctorname',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Date:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$date',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Text(
                'PatientID:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$ic',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Patient Name:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$name',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Illness:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$illness',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Medication:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$medication',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Important:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$important',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red,
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      )
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      )
                    ),
                    onPressed: () async {
                        // setState(() => loading = true);
                        // await DatabaseService().createPrescription( useruid, date, _newDoctor.name, ic, illness, medication, important, name);
                        // setState(() => loading = false);
                        // Navigator.pop(context);
                        // PrescriptionDetails _newPrescription = new PrescriptionDetails(uuid: useruid, date: date, doctorname: _newDoctor.name, ic: patientic, illness: illness, medication: meds, important: important, patientname: name);
                        // Navigator.push(
                        //   context, 
                        //   MaterialPageRoute(builder: (context) => ConfirmPrescription(prescriptionDetails: _newPrescription,))
                        // );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}