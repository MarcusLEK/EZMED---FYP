import 'package:ezmed/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezmed/models/user.dart';
import 'package:ezmed/screens/home/admin/admin_home.dart';
import 'package:ezmed/screens/home/staff/staff_home.dart';
import 'package:ezmed/screens/home/patient/home.dart';
import 'package:ezmed/screens/home/doctor/doctor_home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    print(user);

    // return home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      // return Admin home
      //return AdminHome();

      // return patient home
      return Home(uid: user.uid);
      
      // return staff home
      //return StaffHome(uid: user.uid);

      // return doctor home
      //return DoctorHome(uid: user.uid);

    }
  }
}