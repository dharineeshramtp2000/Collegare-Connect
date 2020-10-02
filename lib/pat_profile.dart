import 'package:company/menu.dart';
import 'package:company/widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
String _idpat = '';

class pat_profile extends StatefulWidget {
  @override
  _pat_profileState createState() => _pat_profileState();
}

class _pat_profileState extends State<pat_profile> {

  getUserInfogetChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _idpat = prefs.getString('idpat');
    //print(Constants.myName);

    setState(() {
      _idpat = (prefs.getString('idpat') ?? '');
    });
  }
  @override
  void initState() {
    super.initState();
    getUserInfogetChats();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        home: Scaffold(

          appBar: AppBar(title: Text('Profile',style: TextStyle(
            color: Colors.black,

            fontSize: 30.0,
          ),),
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

          body:Container(


            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('image/sign.png'),
                  fit: BoxFit.cover
              ) ,
            ),
            padding:EdgeInsets.all(15.0),




            child:Column(

              children: [
//SizedBox(width: 1000,),
                SizedBox(height: 90,),


                SizedBox(height: 30,),
                Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/user.png'), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(80.0),
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                ),
                SizedBox(height: 15,),


                Text(
                  _idpat,
                  style: TextStyle(

                    fontSize: 25.0,
                    color: Colors.black54,

                  ),
                ),
                SizedBox(height: 15,),
                SizedBox(width: 400.0,
                  height: 1.0,
                  child: const DecoratedBox(
                    decoration: const BoxDecoration(
                        color: Colors.black87
                    ),
                  ),),
                SizedBox(height: 15,),
                Text(
                  'Update Data',
                  style: TextStyle(

                    fontSize: 25.0,
                    color: Colors.black,

                  ),
                ),
                SizedBox(height: 15,),
                SizedBox(width: 400.0,
                  height: 1.0,
                  child: const DecoratedBox(
                    decoration: const BoxDecoration(
                        color: Colors.black87
                    ),
                  ),),

                SizedBox(height: 15,),
                GestureDetector(
                  onTap: () async {

                    SharedPreferences prefs = await SharedPreferences
                        .getInstance();
                    prefs.remove('idpat');
                    Navigator.pushReplacement(context,
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
                SizedBox(height: 15,),
                SizedBox(width: 400.0,
                  height: 1.0,
                  child: const DecoratedBox(
                    decoration: const BoxDecoration(
                        color: Colors.black87
                    ),
                  ),),

              ],
            ),
          ),
        ),

      ),
    );
  }
}
