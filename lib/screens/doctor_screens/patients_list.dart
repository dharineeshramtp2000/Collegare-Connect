import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/menu_hospital.dart';
import 'package:company/screens/doctor_screens/doctor_home.dart';
import 'package:company/screens/doctor_screens/loading_details.dart';
import 'package:company/services/doctor_services/doctor_products_info.dart';
import 'package:company/services/doctor_services/filtered_patients_details.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class PatientsList extends StatefulWidget {
  final List<FilteredPatientsDetails> patientslist;
  final DoctorProductInfo selectedproductinfo;




  PatientsList({this.patientslist,this.selectedproductinfo});

  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  List<FilteredPatientsDetails> patientslist;
  DoctorProductInfo selectedproductinfo;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    patientslist = widget.patientslist;
    selectedproductinfo = widget.selectedproductinfo;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 40.0, right: 15.0, left: 15.0, bottom: 10.0),
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Choose the Desired',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: kDoctorPrimaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Ubuntu'),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
                child: Icon(Icons.chevron_left, color: kDoctorPrimaryColor)),
          ],
        ),
        Text(
          'Patients',
          style: TextStyle(
              decoration: TextDecoration.none,
              color: kDoctorPrimaryColor,
              fontSize: 30.0,
              fontWeight: FontWeight.w500,
              fontFamily: 'CarterOne'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: patientslist.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingDetails(patientId: patientslist[index].id,)));
                },
                child: Container(
                  height: 100.0,
                  child: Card(
                    color: Color(0xFFE7EFFA),
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQuIM2Kwi_1IOCBHfB3z2CZWpjl7igvaMpYZw&usqp=CAU'),
                              ),
                            ],
                          ),
                          Text(
                            patientslist[index].name,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Viga'),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  patientslist.removeAt(index);
                                });
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            print(selectedproductinfo.title);
            print(patientslist[0].id);

            for (FilteredPatientsDetails patient in patientslist)
            {
              _firestore.collection('hosptial').doc('patients').collection(patient.id).doc(patient.id).collection('recommend_products').add({
                'name':selectedproductinfo.title,
                'tagline':selectedproductinfo.tagLine,
                'tags':selectedproductinfo.tags,
                'description':selectedproductinfo.description,
                'uses':selectedproductinfo.uses,
                'weblink':selectedproductinfo.webLink,
                'companyname':selectedproductinfo.companyName,
                'image':selectedproductinfo.imageUrl,
                'sender':selectedproductinfo.sender,
              }


              );



            }
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>menu_hospital()));

          },
          child: Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ], color: Colors.blue, borderRadius: BorderRadius.circular(15.0)),
            child: Center(

                  child: Text(
              'Send',
              style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
            ),
                )),

        ),
      ]),
    );
  }
}
