import 'package:flutter/material.dart';

class MessageBuilder extends StatelessWidget {
  final String text;
  final String sender;
  final String currentProfile;
  MessageBuilder({this.sender,this.text,this.currentProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: (sender == currentProfile)? CrossAxisAlignment.end: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Material(
            borderRadius: (sender == currentProfile)? BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft:  Radius.circular(30.0),bottomRight:  Radius.circular(30.0)):BorderRadius.only(topRight: Radius.circular(30.0),bottomLeft:  Radius.circular(30.0),bottomRight:  Radius.circular(30.0)),
            elevation: 5.0,
            color: (sender == currentProfile)?Colors.blue:Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Text(text,style: TextStyle(color:(sender == currentProfile)? Colors.white:Colors.black87,fontFamily: 'Ubuntu'),),
            ),
          ),
        ),
      ],
    );
  }
}
