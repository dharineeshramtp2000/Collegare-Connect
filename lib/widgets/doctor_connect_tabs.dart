import 'package:company/constants.dart';
import 'package:flutter/material.dart';

class DoctorConnectTabs extends StatelessWidget {

  final String specialization;
  DoctorConnectTabs({this.specialization});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(specialization,
            style: TextStyle(
                color: kDoctorPrimaryColor,
                fontFamily: 'KumbhSans',
                fontWeight: FontWeight.w600)),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }
}