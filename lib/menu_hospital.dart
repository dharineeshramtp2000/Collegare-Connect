import 'package:company/menu.dart';
import 'package:company/screens/chat_screen.dart';
import 'package:company/screens/doctor_screens/doctor_connect.dart';
import 'package:company/screens/doctor_screens/doctor_home.dart';
import 'package:company/widget.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _iddoc = '';
String _docsp = '';
var ress;
class menu_hospital extends StatefulWidget {
  @override
  _menu_hospitalState createState() => _menu_hospitalState();
}

class _menu_hospitalState extends State<menu_hospital> {
  int _currentIndex = 0;
  PageController _pageController;

  getUserInfogetChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _iddoc = prefs.getString('iddoc');
    SharedPreferences pref = await SharedPreferences.getInstance();
    _docsp = prefs.getString('docsp');
    //print(Constants.myName);

    setState(() {
      _iddoc = (prefs.getString('iddoc') ?? '');
      _docsp = (prefs.getString('docsp') ?? '');

    });


  }
  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    super.initState();
    getUserInfogetChats();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            DoctorHomePage(),
            DoctorConnect(),
            Chat(currentProfile: _iddoc,),
            Container(
              child: MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                      ),
                    ),
                    elevation: 0.0,
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
//                leading: IconButton(
//                  icon: Icon(Icons.arrow_back_ios),
//                  onPressed: () {
//                    Navigator.pushReplacement(context,
//                        MaterialPageRoute(builder: (context) => menu()));
//                  },
//                ),
                  ),
                  extendBodyBehindAppBar: true,
                  body: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('image/sign.png'),
                          fit: BoxFit.cover),
                    ),
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 90,
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 140.0,
                          height: 140.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQuIM2Kwi_1IOCBHfB3z2CZWpjl7igvaMpYZw&usqp=CAU'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(80.0),
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 2.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        Text(
                          _iddoc,
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 400.0,
                          height: 1.0,
                          child: const DecoratedBox(
                            decoration:
                                const BoxDecoration(color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Update Data',
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 400.0,
                          height: 1.0,
                          child: const DecoratedBox(
                            decoration:
                                const BoxDecoration(color: Colors.black87),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('iddoc');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => menu()));
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Icon(Icons.exit_to_app)),
                        ),
                        Text(
                          'Signout',
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 400.0,
                          height: 1.0,
                          child: const DecoratedBox(
                            decoration:
                                const BoxDecoration(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: Text('Home'), icon: Icon(Icons.home)),
          BottomNavyBarItem(
              title: Text('Connect'), icon: Icon(Icons.near_me)),
          BottomNavyBarItem(title: Text('Chat'), icon: Icon(Icons.message)),
          BottomNavyBarItem(
              title: Text('Settings'), icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
