import 'package:company/menu.dart';
import 'package:company/screens/chat_screen.dart';
import 'package:company/screens/company_screens/add_product.dart';
import 'package:company/screens/company_screens/chat_company.dart';
import 'package:company/screens/company_screens/home_dart.dart';
import 'package:company/screens/company_screens/profile.dart';
import 'package:company/widget.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _comp = '';
String _companyname='';
class menu_company extends StatefulWidget {
  @override
  _menu_companyState createState() => _menu_companyState();
}

class _menu_companyState extends State<menu_company> {
  bool initialized = false;

  List<Widget> tabs = [
    CompanyHomePage(companyName: _companyname,),
    ChatCompany(),
    CompanyProfile(),
  ];

  int _currentIndex = 0;
   getUserInfogetChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _comp = prefs.getString('comp');
    _companyname =prefs.getString('company_name');
    //print(Constants.myName);

    setState(() {
      _comp = (prefs.getString('comp') ?? '');
      _companyname = (prefs.getString('company_name') ?? '');
      print('companyyy');
      print(_companyname);
    });
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      initialized = true;
      setState(() {});
    });
    getUserInfogetChats();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
        leading: Icon(Icons.menu),
      backgroundColor: Colors.blue,
      title: Text('Collegare',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Viga'),),
    ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30.0,
        ),
      ),
      body: (initialized)?tabs[_currentIndex]:Container(child: Text('loading'),),
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
              icon: Icon(Icons.message, color: Colors.blue),
              title: Text(
                'Chat',
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.blue),
              title: Text(
                'Settings',
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
}


