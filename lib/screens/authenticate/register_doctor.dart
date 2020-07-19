import 'package:ezmed/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/services/auth.dart';
import 'package:ezmed/shared/constant.dart';

class RegisterDoctor extends StatefulWidget {

  @override
  _RegisterDoctorState createState() => _RegisterDoctorState();
}

class _RegisterDoctorState extends State<RegisterDoctor> {

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
        title: Text('Create Doctor Account'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter doctor email' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Email e.g. example@mail.com'),
                onChanged: (val) {
                  setState(() => email = val);
                  setState(() => password = email);
                }
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter doctor name' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Doctor Name'),
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
              SizedBox(height: 20),
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
                  'Register New Doctor',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  )
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerDoctor(email, password, name, contact);
                    if (result == null) {
                      setState(() {
                        error = 'Failed to register doctor';
                        loading = false;
                      });
                    } else {
                      setState(() {
                        error = 'Doctor registration successful!';
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