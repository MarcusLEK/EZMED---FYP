import 'package:ezmed/screens/authenticate/update_appointment.dart';
import 'package:ezmed/services/database.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/models/appointment.dart';

class ViewAppointmentDetails extends StatefulWidget {

  final Appointment newAppointment;
  ViewAppointmentDetails({ this.newAppointment });


  @override
  _ViewAppointmentDetailsState createState() => _ViewAppointmentDetailsState(appointment: newAppointment);
}

class _ViewAppointmentDetailsState extends State<ViewAppointmentDetails> {

  Appointment appointment;
  _ViewAppointmentDetailsState({ this.appointment });

  String uuid;
  String date;
  String time;
  String ic;
  String note;
  String status;
  String createdby;
  String patientname;
  bool delete = false;
  String error = '';

  void setData() {
    uuid = appointment.uuid;
    date = appointment.date;
    time = appointment.time;
    ic = appointment.ic;
    status = appointment.status;
    note = appointment.note;
    createdby = appointment.createdby;
    patientname = appointment.patientname;
  }

  void refreshData(Appointment appointment) {
    date = appointment.date;
    time = appointment.time;
    note = appointment.note;
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Appointment'),
          content: Text(
            'Are you sure? \nThis action cannot undo.',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: 50,
            ),
            FlatButton(
              color: Colors.red,
              child: Text(
                'CONFIRM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
              onPressed: () {
                setState(() => delete = true);
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  void check(bool del) {
    if (del == true) {
      //print('appointment deleted');
      DatabaseService().deleteAppointment(uuid);
      //setState(() => delete = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    setData();
    check(delete);
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ), 
            onPressed: () {
              print(delete);
              _showDialog();
              check(delete);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                error,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Created By',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$createdby',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Patient ID',
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
              SizedBox(height: 20),
              Text(
                'Patient Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$patientname',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Appointment Date',
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
              SizedBox(height: 20),
              Text(
                'Appointment Time',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$time',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Status',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$status',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '$note',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.red,
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                      onPressed: () async {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => UpdateAppointment(oldAppointment: appointment))
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}