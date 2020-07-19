import 'package:ezmed/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/services/auth.dart';
import 'package:ezmed/shared/constant.dart';

class ResetPW extends StatefulWidget {

  final Function toggleView;
  ResetPW({this.toggleView});

  @override
  _ResetPWState createState() => _ResetPWState();
}

class _ResetPWState extends State<ResetPW> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Reset Password')
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Enter email that used to create EZMED account.',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Email e.g example@mail.com'),
                onChanged: (val) {
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  )
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.resetPassword(email);
                    if (result == null) {
                      setState(() {
                        error = 'Password Reset Successful \nPlease check your inbox, spam or trash for the email.';
                        loading = false;
                      });
                    } else {

                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error, 
                style: TextStyle(
                  color: Colors.red, 
                  fontSize: 14
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}