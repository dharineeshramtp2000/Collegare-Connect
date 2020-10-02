import 'package:company/sign_doctor.dart';
import 'package:company/sign_hosadmin.dart';
import 'package:company/widget.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

class sign_hosptial extends StatefulWidget {
  @override
  _sign_hosptialState createState() => _sign_hosptialState();
}

class _sign_hosptialState extends State<sign_hosptial> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => menu()));
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        body:Container(


          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('image/Slice.png'),
                fit: BoxFit.cover
            ) ,
          ),
          padding:EdgeInsets.all(15.0),
          child:Column(
            children: [

              SizedBox(height: 100,),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    'Sign In As:',
                    textAlign: TextAlign.left,
                    style: signupTextstyle(40.0),
                  ),
                ),
              ),

              SizedBox(height: 280),





              FlatButton(
                color: Colors.transparent,

                onPressed: () {

                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => sign_hosadmin()));
                },
                child: Container(
                  decoration:  BoxDecoration(

                    border: new Border.all(

                        color: Color(0xff00ffaa), width: 1),
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xff6DD8D2),
                        Color(0xff6DD8D2),
                        Color(0xff6DD8D2),
                      ],
                    ),
                  ),
                  padding:EdgeInsets.all(10.0),
                  child: const Text(
                      'Sign In As Hospital Admin',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),

              SizedBox(height: 30,),

              FlatButton(
                color: Colors.transparent,

                onPressed: () {

                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => sign_doctor()));
                },
                child: Container(
                  decoration:  BoxDecoration(

                    border: new Border.all(

                        color: Color(0xff00ffaa), width: 1),
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xff6DD8D2),
                        Color(0xff6DD8D2),
                        Color(0xff6DD8D2),
                      ],
                    ),
                  ),
                  padding:EdgeInsets.all(10.0),
                  child: const Text(
                      'Sign In As Hospital Doctor/Staff',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),











            ],
          ),
        ),
      ),
    );

  }
}
