import 'package:company/constants.dart';
import 'package:company/main.dart';
import 'package:company/services/company_services/doctor_info.dart';
import 'package:company/services/doctor_services/doctor_firebase.dart';
import 'package:company/widgets/doctor_display_card.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _idpat='';
String _iddoc = '';
String _docsp = '';
class DoctorProfile extends StatefulWidget {
  DoctorProfile({this.specialization});
  final String specialization;
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool showSpinner = true;
  List<DoctorInfo> doctorList = [];
  getUserInfogetChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _iddoc = prefs.getString('iddoc');
    SharedPreferences pref = await SharedPreferences.getInstance();
    _docsp = prefs.getString('docsp');
    SharedPreferences pre = await SharedPreferences.getInstance();
    _idpat = prefs.getString('idpat');
    //print(Constants.myName);

    setState(() {
      _iddoc = (prefs.getString('iddoc') ?? '');
      _docsp = (prefs.getString('docsp') ?? '');
      _idpat = (prefs.getString('idpat') ?? '');


    });
  }

  void getDoctorData() async {
    DoctorFirebaseServices services = DoctorFirebaseServices();
    List<dynamic> doctors =
        await services.getDoctors(specialization: widget.specialization);
    print(doctors);
    for (var doctor in doctors) {
      doctorList.add(await services.displayDoctor(
          doctorId: doctor.toString(), specialization: widget.specialization));
    }
    setState(() {
      showSpinner = false;
    });
  }

  List<Widget> doctorDetails() {
    List<DoctorDisplayCard> doctors = [];
    for (DoctorInfo data in doctorList) {
      doctors.add(DoctorDisplayCard(
        name: data.doctorName,
        patients: data.doctorPatients,
        experience: data.doctorExperience,
        imageurl: data.imageUrl,
        reciever: data.doctorId,
        sender: (_iddoc!='')?_iddoc:_idpat,
      ));
    }
    return doctors;
  }

  @override
  void initState() {
    getUserInfogetChats();
    getDoctorData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
        color: Color(0xFFE7EFFA),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          padding: const EdgeInsets.all(8.0),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          children: doctorDetails(),
        ),
      ),
    );
  }
}
