# Description
This project is a Flutter and Firebase medical tracking application.
This application was developed on VS code on windows 10.
Devices tested:
- Oneplus 6
- Nexus 5
- Pixel 2

# Installation and running
Before you can run this application you have to install a couple of things
    1. Install android studio and an emulator with API level > 21.
    2. Install VS code with flutter and dart extensions.
    
To run the program, first start up the android emulator.
Hit F5 or select the android emulator to deploy the app.

# Issues 
Due to the login being not able to merge and used for all users, the following solution has been implemented
{
    Before deploying this to a usable application, please change the the accordingly for each user.
    # Patient
    - In wrapper.dart, change the return statement to "return Home()"

    # Admin
    - - In wrapper.dart, change the return statement to "return AdminHome()"

    # Doctor
    - In wrapper.dart, change the return statement to "return DoctorHome()"

    # Staff
    - In wrapper.dart, change the return statement to "return StaffHome()"
}

# Project Status
This project is completed as a Final Year Project and will not longer be updated or supported.