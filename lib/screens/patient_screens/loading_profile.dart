import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/screens/patient_screens/patient_profile.dart';
import 'package:company/services/doctor_services/doctor_firebase.dart';
import 'package:company/services/patient_services/patient_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingProfile extends StatefulWidget {
  @override
  _LoadingProfileState createState() => _LoadingProfileState();
}

class _LoadingProfileState extends State<LoadingProfile> {
  final _firestore = FirebaseFirestore.instance;

  bool showSpinner = true;
//DoctorFirebaseServices services = DoctorFirebaseServices();
String _idpat;
  void calculateDetails()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _idpat = prefs.getString('idpat');
    //print(Constants.myName);

    setState(() {
      _idpat = (prefs.getString('idpat') ?? '');

    });

    //PatientProfileInfo info = await services.fetchProfile();
    print('0');
    final result = await _firestore.collection('hosptial').doc('patients')
        .collection(_idpat).doc('personal_details').get();

    String name = await result.get('name').toString();

    String id = await result.get('id').toString();
    String address = await result.get('address').toString();

    String age = await result.get('age').toString();
    String gender = await result.get('sex').toString();
    String bp = await result.get('bp').toString();
    String sugar = await result.get('sugar').toString();
    String hemo = await result.get('hemo').toString();
    List<dynamic> past_history = await result.get('past_history');

    List<dynamic> drug_history = await result.get('drug_history');
    Map<dynamic, dynamic> medical_history = await result.get(
        'medical_history');


    PatientProfileInfo info = PatientProfileInfo(name: name,id: id,address:address,age: age,gender: gender,bp: bp,sugar: sugar,hemo: hemo,past_history: past_history,drug_history: drug_history,medical_history: medical_history);

    print('1');
   setState(() {
      showSpinner= false;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PatientProfile(info: info,)));

  }

  @override
  void initState() {
calculateDetails();
    super.initState();



  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
        color: Colors.white,

      ),
    );
  }
}
