import 'package:company/constants.dart';
import 'package:company/screens/chat_list.dart';
import 'package:company/screens/company_screens/chat_list_company.dart';
import 'package:company/screens/medical_shops/chat_list_shop.dart';
import 'package:company/screens/patient_screens/chat_list_patient.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../menu.dart';

class ChatShop extends StatefulWidget {
  @override
  _ChatShopState createState() => _ChatShopState();
}

class _ChatShopState extends State<ChatShop> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: ()async{
                SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.remove('shop_id');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>menu()));
              },
              child: Icon(
                Icons.exit_to_app,
                color: kDoctorPrimaryColor,
              ),
            ),
            SizedBox(
              width: 20.0,
            )
          ],
          backgroundColor: Colors.white,
          title: Text(
            'Chat...',
            style: TextStyle(color: kDoctorPrimaryColor, fontFamily: 'Viga'),
          ),

        ),
        body: ChatListShop(),
      ),
    );
  }
}
