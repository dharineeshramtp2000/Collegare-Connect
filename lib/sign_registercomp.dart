import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/menu.dart';
import 'package:company/okpage.dart';
import 'package:company/widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class sign_registercomp extends StatefulWidget {
  @override
  _sign_registercompState createState() => _sign_registercompState();
}

class _sign_registercompState extends State<sign_registercomp> {


  String text = '';
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController domainEditingController = new TextEditingController();
  TextEditingController panEditingController = new TextEditingController();
  TextEditingController aadharEditingController = new TextEditingController();
  TextEditingController addressEditingController = new TextEditingController();
  TextEditingController nocEditingController = new TextEditingController();
  TextEditingController rentEditingController = new TextEditingController();






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
        firestoreInstance.collection("company").document("all_companies").collection(nameEditingController.text).doc("company_details").set(
            {
              "name" : nameEditingController.text,
              "domain" : domainEditingController.text,
              "PAN" : panEditingController.text,
              "aadhar" : aadharEditingController.text,
              "address_proof" : addressEditingController.text,
              "NOC" : nocEditingController.text,
              "rent" : rentEditingController.text,

            }).then((value){
          //print(value.documentID);

        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => okpage()));




      }
      catch (e) {
        print(e.toString());
        setState(() {
          isLoading = false;
          text = 'Some problem try later!!';
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

        body:SingleChildScrollView(
          child: Container(


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
                :SingleChildScrollView(

              child: Container
                (
                child:Column(

                  children: [

                    SizedBox(height: 80,),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          'Register Company:',
                          textAlign: TextAlign.left,
                          style: signupTextstyle(40.0),
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),




                    Form(
                      key: formKey,

                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          children: [

                            SizedBox(height: 40,),
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Text(
                                        'Company Name', style: signupTextstyle(18.0)),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              style: simpleTextStyle(),
                              controller: nameEditingController,
                              validator: (val) {
                                return val.isEmpty || val.length < 3
                                    ? "Enter Username 3+ characters"
                                    : null;
                              },
                              decoration: inputdecoration('username'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Text(
                                        'Company Domain ID', style: signupTextstyle(18.0)),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              style: simpleTextStyle(),
                              controller: domainEditingController,
                              validator: (val) {
                                return val.isEmpty || val.length < 3
                                    ? "Enter Username 3+ characters"
                                    : null;
                              },

                              //validator: (value) => checkUserValue(value) ? "Enter Valid Email id" : null,

//                          validator: (val) {
//                            if (val.isEmpty && checkExist(val)) {
//                              return "Enter vaild Emailid";
//                            } else {
//                              return null;
//                            }
//                          },
                              decoration: inputdecoration('email'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Text(
                                        'Company PAN Number', style: signupTextstyle(18.0)),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              style: simpleTextStyle(),
                              controller: panEditingController,
                              validator: (val) {
                                return val.isEmpty || val.length < 6
                                    ? "Enter ID 6+ characters"
                                    : null;
                              },
                              decoration: inputdecoration('id'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Text(
                                        'Company Aadhar Number', style: signupTextstyle(18.0)),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              style: simpleTextStyle(),
                              controller: aadharEditingController,
                              validator: (val) {
                                return val.isEmpty || val.length < 12
                                    ? "Enter ID 12 characters"
                                    : null;
                              },
                              decoration: inputdecoration('id'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Text(
                                        'Company Address Proof', style: signupTextstyle(18.0)),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              style: simpleTextStyle(),
                              controller: addressEditingController,
                              validator: (val) {
                                return val.isEmpty || val.length < 3
                                    ? "Enter UserID 3+ characters"
                                    : null;
                              },
                              decoration: inputdecoration('id'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Text(
                                        'NOC from Owner', style: signupTextstyle(18.0)),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              style: simpleTextStyle(),
                              controller: nocEditingController,
                              validator: (val) {
                                return val.isEmpty || val.length < 3
                                    ? "Enter UserID 3+ characters"
                                    : null;
                              },
                              decoration: inputdecoration('id'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Text(
                                        'Rent Agreement', style: signupTextstyle(18.0)),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              //obscureText: true,
                              controller: rentEditingController,
                              validator: (val) {
                                return val.isEmpty || val.length < 3
                                    ? "Enter UserID 3+ characters"
                                    : null;
                              },
                              style: simpleTextStyle(),
                              decoration: inputdecoration('password'),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text(
                                text,textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),




                            SizedBox(height: 20,),

                            FlatButton(
                              color: Colors.transparent,

                              onPressed: () {
                                //signIn();
                                Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => okpage()));

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
                                    'Submit!',
                                    style: TextStyle(fontSize: 20)
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),


                          ],
                        ),
                      ),
                    ),









                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}