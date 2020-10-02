import 'package:company/constants.dart';
import 'package:company/screens/doctor_screens/patients_list.dart';
import 'package:company/services/doctor_services/doctor_firebase.dart';
import 'package:company/services/doctor_services/doctor_products_info.dart';
import 'package:company/services/doctor_services/filtered_patients_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PatientsFilter extends StatefulWidget {
  final DoctorProductInfo selectedproductinfo;

  PatientsFilter({this.selectedproductinfo});

  @override
  _PatientsFilterState createState() => _PatientsFilterState();
}
enum Gender {Male,Female,Both}
class _PatientsFilterState extends State<PatientsFilter> {
  DoctorProductInfo selectedproductinfo;

  DoctorFirebaseServices services = DoctorFirebaseServices();
  String selectedSpecialization = 'Cardiology';
  RangeValues _values;
  int bpStart = 80;
  int bpEnd = 120;
  int sugarStart = 90;
  int sugarEnd = 120;
  int ageStart = 10;
  int ageEnd = 40;
  int hemoStart = 13;
  int hemoEnd = 17;
  int esoStart = 700;
  int esoEnd = 800;
  String bpSI = 'mm/Hg';
  String sugarSI = 'mg/dL';
  Color maleCardColor  = Colors.lightBlueAccent;
  Color femaleCardColor  = Colors.lightBlueAccent;
  Color bothCardColor = Colors.lightBlueAccent;
  Gender selectedCard;
  bool showSpinner = false;
  List<String> _tags = [];

  List<PopupMenuEntry> _popupMenuBuilder(String tag) {
    return <PopupMenuEntry>[
      PopupMenuItem(
        child: Text(tag, style: TextStyle(color: Colors.blueGrey)),
        enabled: false,
      ),
      PopupMenuDivider(),
      PopupMenuItem(
        value: 1,
        child: Row(
          children: <Widget>[
            Icon(Icons.content_copy),
            Text("Copy text"),
          ],
        ),
      ),
    ];
  }

  @override
  void initState() {
    selectedproductinfo  = widget.selectedproductinfo;
    _tags.addAll([]);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            padding:
                EdgeInsets.only(top: 40.0, right: 15.0, left: 15.0, bottom: 10.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Text(
                  'Patients',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: kDoctorPrimaryColor,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'CarterOne'),
                ),
                SizedBox(
                  height: 20.0
                ),
                Text('Gender', style: kFilterFormTitleTextStyle),
                Container(
                  height: 100.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap:(){
                            setState(() {
                              maleCardColor = Colors.blue;
                              femaleCardColor = Colors.lightBlueAccent;
                              bothCardColor = Colors.lightBlueAccent;
                              selectedCard = Gender.Male;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                color: maleCardColor,
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            child: Center(
                              child: Text('Male',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                color: Colors.white,
                                fontFamily: 'Viga',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                              ),),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap:(){
                            setState(() {
                              maleCardColor = Colors.lightBlueAccent;
                              femaleCardColor = Colors.blue;
                              bothCardColor = Colors.lightBlueAccent;
                              selectedCard = Gender.Female;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                color: femaleCardColor,
                                borderRadius: BorderRadius.circular(15.0)
                            ),
                            child: Center(
                              child: Text('Female',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontFamily: 'Viga',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0
                                ),),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap:(){
                            setState(() {
                              maleCardColor = Colors.lightBlueAccent;
                              femaleCardColor = Colors.lightBlueAccent;
                              bothCardColor = Colors.blue;
                              selectedCard = Gender.Both;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                color: bothCardColor,
                                borderRadius: BorderRadius.circular(15.0)
                            ),
                            child: Center(
                              child: Text('Both',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontFamily: 'Viga',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0
                                ),),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 20.0
                ),
                Text('Age', style: kFilterFormTitleTextStyle),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF1151b8),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                  padding: EdgeInsets.all(12.0),
                  height: 140.0,
                  child: Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '${ageStart.toString()}-${ageEnd.toString()}',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Viga'
                              ),
                            ),
                          ],
                        ),
                        Card(
                            elevation: 0,
                            color: Color(0xFF1151b8),
                            child: RangeSlider(
                              inactiveColor: Color(0xFF8D8E98),
                              activeColor: Color(0xFFEB1555),
                              min: 0.0,
                              max: 100.0,
                              values: RangeValues(ageStart.toDouble(), ageEnd.toDouble()),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  ageStart = values.start.round();
                                  ageEnd = values.end.round();
                                });
                              },
                            )

                        )
                      ],
                    ),

                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Choose Target specialization', style: kFilterFormTitleTextStyle),
                Card(
                  elevation: 0,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20.0),
                    child: DropdownButton<String>(
                      value: selectedSpecialization,
                      items: kSpecializationDropDown,
                      onChanged: (value) {
                        setState(() {
                          selectedSpecialization = value;
                        });
                        print(value);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Add the end Targeted illness', style: kFilterFormTitleTextStyle),
                Card(
                  elevation: 0,
                  child: InputTags(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    tags: _tags,
                    suggestionsList: [
                      "Type 1 Diabetes",
                      "Type 2 Diabetes",
                      "Gestational Diabetes",
                      "Hemorrhoid",
                      "Lupus",
                      "Shingles",
                      "Herpes",
                      "Pneumonia",
                      "HPV",
                      "Fibromyalgia",
                      "Scabies",
                      "Bronchitis",
                      "Strep Throat",
                      "Shingles",
                      "Kidney Stones",
                      "Mouth Ulcer"
                    ],
                    popupMenuBuilder: _popupMenuBuilder,
                    popupMenuOnSelected: (int id, String tag) {
                      switch (id) {
                        case 1:
                          Clipboard.setData(ClipboardData(text: tag));
                          break;
                        case 2:
                          setState(() {
                            _tags.remove(tag);
                          });
                      }
                    },
                    onDelete: (tag) => print(tag),
                    onInsert: (tag) => print(tag),
                  ),
                ),
                SizedBox(
                    height: 20.0
                ),
                Text('Blood Pressure', style: kFilterFormTitleTextStyle),

//            Slider(
//
//            ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFF1151b8),
                  borderRadius: BorderRadius.circular(12.0)
                ),
                padding: EdgeInsets.all(12.0),
                height: 140.0,
                child: Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${bpStart.toString()}-${bpEnd.toString()}',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Viga'
                            ),
                          ),
                          Text(
                            'mm/Hg',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.white70,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Viga'
                            ),
                          )
                        ],
                      ),
                      Card(
                        elevation: 0,
                          color: Color(0xFF1151b8),
                        child: RangeSlider(
                          inactiveColor: Color(0xFF8D8E98),
                          activeColor: Color(0xFFEB1555),
                          min: 60.0,
                          max: 160.0,
                          values: RangeValues(bpStart.toDouble(), bpEnd.toDouble()),
                          onChanged: (RangeValues values) {
                            setState(() {
                              bpStart = values.start.round();
                              bpEnd = values.end.round();
                            });
                          },
                        )

//                    Slider(
//                      value: bp.toDouble(),
//                      min: 80.0,
//                      max: 160.0,
//                      activeColor: Color(0xFFEB1555),
//                      inactiveColor: Color(0xFF8D8E98),
//                      onChanged: (double newValue){
//                        setState(() {
//                          bp = newValue.round();
//                        });
//                      },
//                    ),
                      )
                    ],
                  ),

                ),
              ),
                SizedBox(
                    height: 20.0
                ),
                Text('Sugar Levels', style: kFilterFormTitleTextStyle),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF1151b8),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                  padding: EdgeInsets.all(12.0),
                  height: 140.0,
                  child: Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '${sugarStart.toString()}-${sugarEnd.toString()}',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Viga'
                              ),
                            ),
                            Text(
                              sugarSI,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white70,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: 'Viga'
                              ),
                            )
                          ],
                        ),
                        Card(
                            elevation: 0,
                            color: Color(0xFF1151b8),
                            child: RangeSlider(
                              inactiveColor: Color(0xFF8D8E98),
                              activeColor: Color(0xFFEB1555),
                              min: 70.0,
                              max: 200.0,
                              values: RangeValues(sugarStart.toDouble(), sugarEnd.toDouble()),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  sugarStart = values.start.round();
                                  sugarEnd = values.end.round();
                                });
                              },
                            )

                        )
                      ],
                    ),

                  ),
                ),
                SizedBox(
                    height: 20.0
                ),
                Text('Hemoglobin Level', style: kFilterFormTitleTextStyle),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF1151b8),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                  padding: EdgeInsets.all(12.0),
                  height: 140.0,
                  child: Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '${hemoStart.toString()}-${hemoEnd.toString()}',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Viga'
                              ),
                            ),
                            Text(
                              'g/dL',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white70,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: 'Viga'
                              ),
                            )
                          ],
                        ),
                        Card(
                            elevation: 0,
                            color: Color(0xFF1151b8),
                            child: RangeSlider(
                              inactiveColor: Color(0xFF8D8E98),
                              activeColor: Color(0xFFEB1555),
                              min: 10.0,
                              max: 20.0,
                              values: RangeValues(hemoStart.toDouble(), hemoEnd.toDouble()),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  hemoStart = values.start.round();
                                  hemoEnd = values.end.round();
                                });
                              },
                            )

                        )
                      ],
                    ),

                  ),
                ),
                SizedBox(
                    height: 20.0
                ),
                Text('Eosinophils Count', style: kFilterFormTitleTextStyle),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF1151b8),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                  padding: EdgeInsets.all(12.0),
                  height: 140.0,
                  child: Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '${esoStart.toString()}-${esoEnd.toString()}',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Viga'
                              ),
                            ),
                            Text(
                              '/µL',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white70,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: 'Viga'
                              ),
                            )
                          ],
                        ),
                        Card(
                            elevation: 0,
                            color: Color(0xFF1151b8),
                            child: RangeSlider(
                              inactiveColor: Color(0xFF8D8E98),
                              activeColor: Color(0xFFEB1555),
                              min: 500.0,
                              max: 2000.0,
                              values: RangeValues(esoStart.toDouble(), esoEnd.toDouble()),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  esoStart = values.start.round();
                                  esoEnd = values.end.round();
                                });
                              },
                            )
                        )
                      ],
                    ),

                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () async{
                    setState(() {
                      showSpinner = true;
                    });
                    List<FilteredPatientsDetails> filteredpatients = await services.getFilteredPatients(startAge: ageStart,endAge: ageEnd,startBP: bpStart,endBP: bpEnd,startSugar: sugarStart,endSugar: sugarEnd,startHemo: hemoStart,endHemo: hemoEnd,startEso: esoStart,endEso: esoEnd,gender: selectedCard,special: selectedSpecialization,tag: _tags[0]);
                    setState(() {
                      showSpinner = false;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientsList(patientslist: filteredpatients, selectedproductinfo: selectedproductinfo,)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Center(
                        child: Text(
                          'Fetch Patients',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
