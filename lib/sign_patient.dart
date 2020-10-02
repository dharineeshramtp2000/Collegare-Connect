import 'dart:async';


import 'package:company/services/auth.dart';
import 'package:company/services/database.dart';
import 'package:company/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu.dart';
import 'menu_patient.dart';

class sign_patient extends StatefulWidget {
  @override
  _sign_patientState createState() => _sign_patientState();
}

class _sign_patientState extends State<sign_patient> {


  String text = '';
  TextEditingController emailEditingController = new TextEditingController();


  bool found = false;
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  QuerySnapshot userInfoSnapshot;

  signIn() async{
    if (formKey.currentState.validate()) {

      setState(() {
      isLoading = true;
      });



           try {
            WidgetsFlutterBinding.ensureInitialized();
            await Firebase.initializeApp();
            final firestoreInstance = Firestore.instance;

            var result = await firestoreInstance
                .collection("patient_details")
                .where("id", isEqualTo: emailEditingController.text)
                .getDocuments();
            result.documents.forEach((res)async {

                print(res.data);
                found = true;

            });
                if (found==true) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('idpat', emailEditingController.text);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => menu_patient()));
                }

              else{
                setState(() {
                  isLoading = false;
                  text = 'Account Does not found!!';
                });
              }



              }
           catch (e) {
            print(e.toString());
            setState(() {
              isLoading = false;
              text = 'Account Does not found!!!';
            });
          }


    }
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(

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
                image: AssetImage('image/sign.png'),
                fit: BoxFit.cover
            ) ,
          ),
          padding:EdgeInsets.all(15.0),
          child: isLoading
              ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
          :Container
            (
          child:Column(

            children: [

              SizedBox(height: 110,),

              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    'Sign In:',
                    textAlign: TextAlign.left,
                    style: signupTextstyle(40.0),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    'Enter your Hosptial ID to Sign In!!',
                    textAlign: TextAlign.left,
                    style: signupTextstyle(18.0),
                  ),
                ),
              ),





              Form(
                key: formKey,

                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    children: [


                      SizedBox(height: 100,),

                      TextFormField(
                        validator: (val) {

                              return val.length > 6
                                  ? null
                                  : "Enter 6+ characters";
                        },
                        controller: emailEditingController,

                        style: simpleTextStyle(),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 20),
                            prefixIcon: Padding(
                              padding:
                              EdgeInsets.only(top: 15, bottom: 10),
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.black87,
                                size: 30.0,
                              ),
                            ),
                            hintText: 'Patient ID',
                            hintStyle: TextStyle(color: Colors.black38),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff6DD8D2))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          text,textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),


                      SizedBox(height: 50,),

                      FlatButton(
                        color: Colors.transparent,

                        onPressed: () async{


                          signIn();

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
                              'Sign In!!',
                              style: TextStyle(fontSize: 20)
                          ),
                        ),
                      ),


                    ],
                  ),
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
