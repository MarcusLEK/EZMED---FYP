import 'package:ezmed/models/staff.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/shared/loading.dart';
import 'package:ezmed/shared/constant.dart';
import 'package:ezmed/services/database.dart';

class StaffDetails extends StatefulWidget {

  final Staff staff;
  final String id;
  StaffDetails({ this.staff, this.id });

  @override
  _StaffDetailsState createState() => _StaffDetailsState(newStaff: staff, uuid: id);
}

class _StaffDetailsState extends State<StaffDetails> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  final Staff newStaff;
  final String uuid;
  _StaffDetailsState({ this.newStaff, this.uuid });

  String name = '';
  String contact = '';
  String error = '';

  @override
  void initState(){
    name = newStaff.name;
    contact = newStaff.contact;
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Profile Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),       
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Icon(
                Icons.account_circle,
                color: Colors.blueGrey,
                size: 80,
              ),
              SizedBox(height: 20),
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                textAlign: TextAlign.center,
                initialValue: name,
                validator: (val) => val.isEmpty ? 'Enter a name' : null,
                decoration: textInputDecoration.copyWith(hintText: name),
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),
              SizedBox(height: 20),
              Text(
                'Contact',
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                textAlign: TextAlign.center,
                initialValue: contact,
                validator: (val) => val.isEmpty ? 'Enter contact number' : null,
                decoration: textInputDecoration.copyWith(hintText: contact),
                onChanged: (val) {
                  setState(() => contact = val);
                },
              ),
              SizedBox(height: 20.0),
              Text(
                error, 
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.red,
                      child: Text(
                        'Cancel',
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
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await DatabaseService().updateStaffDetails(uuid, name, contact);
                          print(result);
                          setState(() {
                              error = 'Update Successful';
                              loading = false;
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
    );
  }
}