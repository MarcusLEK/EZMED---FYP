import 'package:ezmed/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/services/auth.dart';
import 'package:ezmed/shared/constant.dart';

class RegisterStaff extends StatefulWidget {

  @override
  _RegisterStaffState createState() => _RegisterStaffState();
}

class _RegisterStaffState extends State<RegisterStaff> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String contact = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Create Staff Account'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter staff email' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Email e.g. example@mail.com'),
                onChanged: (val) {
                  setState(() => email = val);
                  setState(() => password = email);
                }
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter staff name' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Staff Name'),
                onChanged: (val) {
                  setState(() => name = val);
                }
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter contact number' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Contact e.g 019XXXXXXX'),
                onChanged: (val) {
                  setState(() => contact = val);
                }
              ),
              SizedBox(height: 30),
              RaisedButton(
                color: Colors.white,
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  )
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Register New Staff',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  )
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerStaff(email, password, name, contact);
                    if (result == null) {
                      setState(() {
                        error = 'Failed to register staff';
                        loading = false;
                      });
                    } else {
                      setState(() {
                        error = 'Staff registration successful!';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error, 
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}