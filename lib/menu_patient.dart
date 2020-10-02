import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/screens/chat_window.dart';
import 'package:company/screens/doctor_screens/doctor_connect.dart';
import 'package:company/screens/patient_screens/chat_patient.dart';
import 'package:company/screens/patient_screens/patient_home.dart';
import 'package:company/services/patient_services/medical_shops_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/patient_screens/loading_profile.dart';

String _idpat = '';

class menu_patient extends StatefulWidget {
  final List<MedicalShopInfo> shops;
  final List<String> shopDetails;

  menu_patient({this.shops, this.shopDetails});
  //menu_patient({Key key}) : super(key: key);
  @override
  _menu_patientState createState() => new _menu_patientState();
}

class _menu_patientState extends State<menu_patient> {
  final _firestore = FirebaseFirestore.instance;
  List<MedicalShopInfo> shops = [];

  int _currentIndex = 0;
  PageController _pageController;
  getUserInfogetChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _idpat = prefs.getString('idpat');
    //print(Constants.myName);

    setState(() {
      _idpat = (prefs.getString('idpat') ?? '');
    });
  }

  bool initialized = false;
  final tabs = [
    PatientHomePage(),
    DoctorConnect(),
    ChatPatient(),
    LoadingProfile(),
  ];
  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      initialized = true;
      setState(() {});
    });
    super.initState();
    _IsSearching = false;
    _list = widget.shopDetails;
    shops = widget.shops;

    getUserInfogetChats();
  }

  Widget appBarTitle = new Text(
    'Collegare',
    style: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Viga'),
  );
  Icon actionIcon = new Icon(Icons.search);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list = [];
  bool _IsSearching;
  String _searchText = "";

  _menu_patientState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }


  Widget chooseBody(bool isSearching, int index) {
    if (isSearching) {
      return ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _buildSearchList(),
      );
    } else {
      return tabs[index];
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildBar(context),

      body: chooseBody(_IsSearching, _currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail, color: Colors.blue),
              title: Text(
                'Chat',
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.mail, color: Colors.blue),
              title: Text(
                'Recents',
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.blue),
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  List<ChildItem> _buildList() {
    //return _list.map((contact) => new ChildItem(name: contact,index: 0,)).toList();
    List<ChildItem> items =[];

    for (int i=0;i<_list.length;i++)
      {
        items.add(ChildItem(name: _list[i],index: i,shops: shops,));

      }
    return items;
  }

  List<ChildItem> _buildSearchList() {
    List<ChildItem> items =[];
    if (_searchText.isEmpty) {
      for (int i=0;i<_list.length;i++)
      {
        items.add(ChildItem(name: _list[i],index: i,shops: shops,));

      }
      return items;
     // return _list.map((contact) => new ChildItem(name: contact,index: 0,)).toList();
    } else {
      List<String> _searchList = List();


      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
          items.add(ChildItem(name: name,index: i,shops: shops,));
        }
      }
      return items;
      //return _searchList.map((contact) => new ChildItem(contact)).toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: actionIcon,
        onPressed: () {
          setState(() {
            if (this.actionIcon.icon == Icons.search) {
              this.actionIcon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _searchQuery,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.white)),
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        'Collegare',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Viga'),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

class ChildItem extends StatelessWidget {
  final String name;
  final int index;
  final List<MedicalShopInfo> shops;
  ChildItem({this.name,this.index,this.shops});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //print('tapped!!' +index.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatWindow(sender: _idpat,reciever: shops[index].id,)));
      },
      child: new ListTile(
        title: new Text(this.name),
      ),
    );
  }
}
