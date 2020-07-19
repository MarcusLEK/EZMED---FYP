import 'package:ezmed/screens/authenticate/register.dart';
import 'package:ezmed/screens/authenticate/reset_pw.dart';
import 'package:ezmed/services/auth.dart';
import 'package:ezmed/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:ezmed/shared/constant.dart';
import 'package:ezmed/screens/authenticate/register.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  // _auth -> private, "_"
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('EZMED Sign In'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
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
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => ResetPW()));
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        )
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => Register())
                        );
                      },
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        )
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Failed to sign in with email and password';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                  ],
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