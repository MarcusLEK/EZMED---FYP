import 'package:ezmed/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/services/auth.dart';
import 'package:ezmed/shared/constant.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String ic = '';
  String contact = '';
  String error = '';
  String queueID = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('EZMED Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: 80,
                color: Colors.green,
              ),
              SizedBox(height: 10),
              Text(
                'Register As Patient',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                error, 
                style: TextStyle(
                  color: Colors.red, 
                  fontSize: 20
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                onChanged: (val) {
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                onChanged: (val) {
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter your name' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Full name as per NRIC/Passport'),
                onChanged: (val) {
                  setState(() => name = val);
                }
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter NRIC/passport number' : null,
                decoration: textInputDecoration.copyWith(hintText: 'NRIC/Passport number'),
                onChanged: (val) {
                  setState(() => ic = val);
                }
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (val) => val.isEmpty ? 'Enter contact number' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Contact e.g 019XXXXXXX'),
                onChanged: (val) {
                  setState(() => contact = val);
                }
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  )
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerPatient(queueID, email, password, name, ic, contact);
                    if (result == null) {
                      setState(() {
                        error = 'Failed to register user';
                        loading = false;
                      });
                    } else {
                      setState(() {
                        error = 'Patient Registration Successful';
                        loading = false;
                      });
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}