import 'package:ezmed/screens/authenticate/register_doctor.dart';
import 'package:ezmed/screens/authenticate/register_staff.dart';
import 'package:ezmed/screens/home/admin/registered_doctor.dart';
import 'package:ezmed/screens/home/admin/registered_staff.dart';
import 'package:ezmed/services/auth.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('EZMED: Admin Home'),
          backgroundColor: Colors.blue,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(30.0),
              sliver: SliverGrid.count(
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Register Staff',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterStaff())
                        );
                      },
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'View Staffs',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => RegisteredStaff())
                        );
                      },
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Register Doctor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterDoctor())
                        );
                      },
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'View Doctors',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => RegisteredDoctor())
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}