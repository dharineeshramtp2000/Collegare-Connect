import 'package:company/constants.dart';
import 'package:company/screens/doctor_screens/doctor_profile.dart';
import 'package:company/widgets/doctor_connect_tabs.dart';
import 'package:flutter/material.dart';

class DoctorConnect extends StatefulWidget {

  @override
  DoctorConnectState createState() => DoctorConnectState();
}

class DoctorConnectState extends State<DoctorConnect> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:12,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Collegarify',
            style: TextStyle(color: kDoctorPrimaryColor, fontFamily: 'Viga'),
          ),
          bottom: TabBar(
            isScrollable: true,
//            unselectedLabelStyle: TextStyle(color: ),
            indicatorColor: kDoctorPrimaryColor,
            labelStyle: TextStyle(
                color: kDoctorPrimaryColor,
                fontFamily: 'KumbhSans',
                fontWeight: FontWeight.w600),
            tabs: [

              DoctorConnectTabs(specialization: 'Cardiology',),
              DoctorConnectTabs(specialization: 'Diabetology',),
              DoctorConnectTabs(specialization: 'Critical Care',),
              DoctorConnectTabs(specialization: 'Emergency Medicine',),
              DoctorConnectTabs(specialization: 'General Laparoscopic',),
              DoctorConnectTabs(specialization: 'Orthopedic',),
              DoctorConnectTabs(specialization: 'Odontology',),



              DoctorConnectTabs(specialization: 'Urology',),
              DoctorConnectTabs(specialization: 'Rheumatology',),
              DoctorConnectTabs(specialization: 'Opthalmology',),

              DoctorConnectTabs(specialization: 'Neurology',),
              DoctorConnectTabs(specialization: 'Endocrinology',),

            ],
          ),
        ),
        body: TabBarView(
          children: [
          DoctorProfile(specialization: 'Cardiology',),
            DoctorProfile(specialization: 'Diabetology',),
            DoctorProfile(specialization: 'Critical_care',),
            DoctorProfile(specialization: 'Emergency Medicine',),
            DoctorProfile(specialization: 'General Laparoscopic',),
            DoctorProfile(specialization: 'Orthopedic',),
            DoctorProfile(specialization: 'Odontology',),

            DoctorProfile(specialization: 'Urology',),
            DoctorProfile(specialization: 'Rheumatology',),
            DoctorProfile(specialization: 'Opthalmology',),
            DoctorProfile(specialization: 'Neurology',),
            DoctorProfile(specialization: 'Endocrinology',),
          ],
        ),
      ),
    );
  }
}


