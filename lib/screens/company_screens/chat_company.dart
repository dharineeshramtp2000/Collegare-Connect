import 'package:company/constants.dart';
import 'package:company/screens/chat_list.dart';
import 'package:company/screens/company_screens/chat_list_company.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatCompany extends StatefulWidget {

  @override
  _ChatCompanyState createState() => _ChatCompanyState();
}

class _ChatCompanyState extends State<ChatCompany> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Icon(Icons.search,color: kDoctorPrimaryColor,),
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
        body:ChatListCompany(),
      ),
    );
  }
}
