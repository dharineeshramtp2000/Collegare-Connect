import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/menu_patient.dart';
import 'package:company/screens/patient_screens/patient_profile.dart';
import 'package:company/services/doctor_services/doctor_firebase.dart';
import 'package:company/services/patient_services/medical_shops_info.dart';
import 'package:company/services/patient_services/patient_profile_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingMenu extends StatefulWidget {
  @override
  _LoadingMenuState createState() => _LoadingMenuState();
}

class _LoadingMenuState extends State<LoadingMenu> {

  bool showSpinner = true;
//DoctorFirebaseServices services = DoctorFirebaseServices();
  String _idpat;
  List<String> _list;

  void init()async {
    _list = List();

    List <MedicalShopInfo> shops = [];
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final _firestore = FirebaseFirestore.instance;

      final result = await _firestore.collection('shop').get();
      for (var doc in result.docs) {
        String name = await doc.get('name').toString();
        String address = await doc.get('address').toString();
        String id=await doc.get('id').toString();
        shops.add(MedicalShopInfo(name: name, address: address,id: id));
        _list.add(name + ' ' + address);
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          menu_patient(shops: shops, shopDetails: _list,)));
      setState(() {
        showSpinner = false;
      });
    }catch(e){print(e);}
  }

  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
init();
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
