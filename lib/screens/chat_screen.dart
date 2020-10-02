import 'package:company/constants.dart';
import 'package:company/screens/chat_list.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  Chat({this.currentProfile});
  final String currentProfile;
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
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
        body:ChatList(currentProfile: widget.currentProfile,),
      ),
    );
  }
}
