import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/constants.dart';
import 'package:company/menu_hospital.dart';
import 'package:company/menu_patient.dart';
import 'package:company/screens/doctor_screens/patients_filtering.dart';
import 'package:company/services/patient_services/patient_profile_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardDetail {
  String title;
  String subtitle;

  CardDetail({this.title, this.subtitle});
}

class DoctorView extends StatefulWidget {
  final PatientProfileInfo info;

  DoctorView({this.info});

  @override
  _DoctorViewState createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  PatientProfileInfo info;
  List<CardDetail> cards = [

  ];
  @override
  void initState() {
    info = widget.info;
    for (var ele in info.medical_history.keys){
      cards.add(CardDetail(title: ele.toString(), subtitle: info.medical_history[ele]));
    }

    super.initState();
  }

  Widget _buildProfileImage(w, h) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/profile.jpeg'), fit: BoxFit.fitHeight),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.blue,
          width: 5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    List<String> a = ['abcde', 'fghas'];
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(

          centerTitle: true,
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>menu_hospital()));
            },
            child: Icon(Icons.chevron_left , color: kDoctorPrimaryColor,),
          ),

          title: Text(
            'Collegare',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Viga'),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: _buildProfileImage(120.0, 120.0),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 25.0,
                    ),
                    Text('   '+info.name,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left),
                    Text(
                      'Patient',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          size: 30.0,
                        ),
                        Text(
                          info.address,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
            Wrap(
              children: [
                Chip(
                  backgroundColor: Colors.blue,
                  label: Text(
                    'Age:'+info.age,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Chip(
                  backgroundColor: Colors.blue,
                  label: Text(
                    'Gender:'+info.gender,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Chip(
                  backgroundColor: Colors.blue,
                  label: Text(
                    'BP:'+info.bp,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Chip(
                  backgroundColor: Colors.blue,
                  label: Text(
                    'Sugar level:'+info.sugar,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Chip(
                  backgroundColor: Colors.blue,
                  label: Text(
                    'Heamoglobin level:'+info.hemo,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 235.0, 10.0),
              child: Text(
                'Drug History',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            for (String i in info.drug_history)
              ListTile(
                leading: Icon(
                  Icons.fiber_manual_record,
                  size: 17.0,
                  color: Colors.blue,
                ),
                title: new Text(
                  i,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 200.0, 10.0),
              child: Text(
                'Medical History',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) => CardListTile(
                  title: cards[index].title,
                  subtitle: cards[index].subtitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  CardListTile({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      color: Colors.blue,
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 1.0,
                color: Colors.white24,
              ),
            ),
          ),
          child: Icon(Icons.history, color: Colors.white),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.linear_scale,
              color: Colors.yellow,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              subtitle,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
