import 'package:company/screens/chat_window.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
class DoctorDisplayCard extends StatelessWidget {
  final String name;
  final String experience;
  final String patients;
  final String imageurl;
  final String reciever;
  final String sender;
  DoctorDisplayCard({this.patients,this.experience,this.name,this.reciever,this.sender,this.imageurl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatWindow(reciever: reciever,sender: sender,)));
      },
      child: Container(
        height: 100.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  color: kDoctorPrimaryColor, fontFamily: 'Viga'),
            ),
            Text(
              'Medicine Specialist',
              style: TextStyle(
                  fontSize: 10.0,
                  color: kDoctorPrimaryColor,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w100),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Experience',
                        style: TextStyle(
                            fontSize: 10.0,
                            color: kDoctorPrimaryColor,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w100),
                      ),
                      Text(
                        '$experience Years',
                        style: TextStyle(
                            color: kDoctorPrimaryColor,
                            fontFamily: 'Viga'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Patients',
                        style: TextStyle(
                            fontSize: 10.0,
                            color: kDoctorPrimaryColor,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w100),
                      ),
                      Text(
                        '${patients}K',
                        style: TextStyle(
                            color: kDoctorPrimaryColor,
                            fontFamily: 'Viga'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Image(
                    image: NetworkImage(imageurl),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}