import 'package:company/constants.dart';
import 'package:company/screens/chat_list.dart';
import 'package:company/screens/company_screens/chat_list_company.dart';
import 'package:company/screens/patient_screens/chat_list_patient.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPatient extends StatefulWidget {

  @override
  _ChatPatientState createState() => _ChatPatientState();
}

class _ChatPatientState extends State<ChatPatient> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Icon(Icons.search,color: kDoctorPrimaryColor,),
            SizedBox(
              width: 20.0,
            )
          ],
          backgroundColor: Colors.white,
          title: Text(
            'Chat...',
            style: TextStyle(color: kDoctorPrimaryColor, fontFamily: 'Viga'),
          ),
//          bottom: TabBar(
//            isScrollable: true,
////            unselectedLabelStyle: TextStyle(color: ),
//            indicatorColor: kDoctorPrimaryColor,
//            labelStyle: TextStyle(
//                color: kDoctorPrimaryColor,
//                fontFamily: 'KumbhSans',
//                fontWeight: FontWeight.w600),
//            tabs: [
//
//              Column(
//                children: [
//                  Text('Companies',
//                      style: TextStyle(
//                          color: kDoctorPrimaryColor,
//                          fontFamily: 'KumbhSans',
//                          fontWeight: FontWeight.w600)),
//                  SizedBox(
//                    height: 10.0,
//                  )
//                ],
//              ),
//              Column(
//                children: [
//                  Text('Doctors',
//                      style: TextStyle(
//                          color: kDoctorPrimaryColor,
//                          fontFamily: 'KumbhSans',
//                          fontWeight: FontWeight.w600)),
//                  SizedBox(
//                    height: 10.0,
//                  )
//                ],
//              ),
//              Column(
//                children: [
//                  Text('Patients',
//                      style: TextStyle(
//                          color: kDoctorPrimaryColor,
//                          fontFamily: 'KumbhSans',
//                          fontWeight: FontWeight.w600)),
//                  SizedBox(
//                    height: 10.0,
//                  )
//                ],
//              ),
//            ],
//          ),
        ),
        body:ChatListPatient(),
      ),
    );
  }
}
