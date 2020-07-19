import 'package:ezmed/models/appointment.dart';
import 'package:ezmed/services/database.dart';
import 'package:ezmed/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/shared/loading.dart';

class UpdateAppointment extends StatefulWidget {

  final Appointment oldAppointment;
  UpdateAppointment({ this.oldAppointment });

  @override
  _UpdateAppointmentState createState() => _UpdateAppointmentState(newAppointment: oldAppointment);
}

class _UpdateAppointmentState extends State<UpdateAppointment> {

  final Appointment newAppointment;
  _UpdateAppointmentState({ this.newAppointment });

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller;
  TextEditingController _controller2;
  TextEditingController _controller3;
  bool loading = false;

  String uuid = '';
  String date = '';
  String time = '';
  String ic = '';
  String note = '';
  String status = '';
  String createdby = '';
  String error = '';

  @override
  void initState(){
    uuid = newAppointment.uuid;
    date = newAppointment.date;
    time = newAppointment.time;
    ic = newAppointment.ic;
    status = newAppointment.status;
    note = newAppointment.note;
    createdby = newAppointment.createdby;
    _controller = TextEditingController(text: date);
    _controller2 = TextEditingController(text: time);
    _controller3 = TextEditingController(text: note);
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('Update Appointment'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
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
                SizedBox(height: 10),
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
                SizedBox(height: 10),
                Text(
                  '$ic',
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
                SizedBox(height: 10),
                Text(
                  '$status',
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
                SizedBox(height: 10),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _controller,
                  validator: (val) => val.isEmpty ? 'Enter valid date' : null,
                  decoration: textInputDecoration.copyWith(hintText: 'e.g. 1-1-2020'),
                  onChanged: (val) {
                    setState(() => date = val);
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Appointment Time',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _controller2,
                  validator: (val) => val.isEmpty ? 'Enter valid time' : null,
                  decoration: textInputDecoration.copyWith(hintText: 'e.g. 2.30 pm'),
                  onChanged: (val) {
                    setState(() => time = val);
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _controller3,
                  decoration: textInputDecoration.copyWith(hintText: 'Notes...'),
                  onChanged: (val) {
                    setState(() => note = val);
                  },
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
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await DatabaseService().updateAppointment(uuid, date, time, note);
                            print(result);
                            setState(() {
                              error = 'Update Successful';
                              loading = false;
                              error = 'Update Successful! \nPlease go back to the appointment list to refresh the appointment.';
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}